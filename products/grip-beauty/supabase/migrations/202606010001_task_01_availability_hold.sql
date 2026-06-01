create schema if not exists grip_beauty;

create extension if not exists pgcrypto;
create extension if not exists btree_gist;

create table if not exists grip_beauty.businesses (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  timezone text not null,
  plan text not null check (plan in ('base', 'premium', 'full_deluxe')),
  hold_duration interval not null default interval '10 minutes',
  handoff_phone text not null,
  created_at timestamptz not null default now()
);

create table if not exists grip_beauty.professionals (
  id uuid primary key default gen_random_uuid(),
  business_id uuid not null references grip_beauty.businesses(id) on delete cascade,
  name text not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  unique (business_id, name)
);

create table if not exists grip_beauty.services (
  id uuid primary key default gen_random_uuid(),
  business_id uuid not null references grip_beauty.businesses(id) on delete cascade,
  name text not null,
  price_ars integer not null check (price_ars >= 0),
  duration interval not null check (duration > interval '0 minutes'),
  buffer interval not null default interval '0 minutes' check (buffer >= interval '0 minutes'),
  deposit_ars integer not null check (deposit_ars >= 0),
  auto_schedule boolean not null default true,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  unique (business_id, name)
);

create table if not exists grip_beauty.professional_services (
  professional_id uuid not null references grip_beauty.professionals(id) on delete cascade,
  service_id uuid not null references grip_beauty.services(id) on delete cascade,
  primary key (professional_id, service_id)
);

create table if not exists grip_beauty.working_hours (
  id uuid primary key default gen_random_uuid(),
  professional_id uuid not null references grip_beauty.professionals(id) on delete cascade,
  iso_dow smallint not null check (iso_dow between 1 and 7),
  starts_at time not null,
  ends_at time not null,
  check (starts_at < ends_at),
  unique (professional_id, iso_dow, starts_at, ends_at)
);

create table if not exists grip_beauty.calendar_blocks (
  id uuid primary key default gen_random_uuid(),
  professional_id uuid not null references grip_beauty.professionals(id) on delete cascade,
  starts_at timestamptz not null,
  ends_at timestamptz not null,
  reason text,
  created_at timestamptz not null default now(),
  check (starts_at < ends_at)
);

create table if not exists grip_beauty.appointments (
  id uuid primary key default gen_random_uuid(),
  business_id uuid not null references grip_beauty.businesses(id) on delete cascade,
  professional_id uuid not null references grip_beauty.professionals(id) on delete restrict,
  service_id uuid not null references grip_beauty.services(id) on delete restrict,
  status text not null check (
    status in ('hold', 'confirmed', 'expired', 'cancelled', 'needs_human_review')
  ),
  customer_label text not null default 'demo_customer',
  starts_at timestamptz not null,
  service_ends_at timestamptz not null,
  blocks_until timestamptz not null,
  hold_expires_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (starts_at < service_ends_at),
  check (service_ends_at <= blocks_until),
  check (
    (status = 'hold' and hold_expires_at is not null)
    or (status <> 'hold')
  )
);

create index if not exists calendar_blocks_professional_range_idx
  on grip_beauty.calendar_blocks
  using gist (professional_id, tstzrange(starts_at, ends_at, '[)'));

create index if not exists appointments_business_status_idx
  on grip_beauty.appointments (business_id, status);

alter table grip_beauty.appointments
  drop constraint if exists appointments_no_active_overlap;

alter table grip_beauty.appointments
  add constraint appointments_no_active_overlap
  exclude using gist (
    professional_id with =,
    tstzrange(starts_at, blocks_until, '[)') with &&
  )
  where (status in ('hold', 'confirmed'));

create or replace function grip_beauty.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists appointments_set_updated_at on grip_beauty.appointments;

create trigger appointments_set_updated_at
before update on grip_beauty.appointments
for each row
execute function grip_beauty.set_updated_at();

create or replace function grip_beauty.expire_holds(
  p_business_id uuid default null,
  p_reference_at timestamptz default now()
)
returns integer
language plpgsql
as $$
declare
  v_expired_count integer;
begin
  update grip_beauty.appointments
     set status = 'expired'
   where status = 'hold'
     and hold_expires_at <= p_reference_at
     and (p_business_id is null or business_id = p_business_id);

  get diagnostics v_expired_count = row_count;
  return v_expired_count;
end;
$$;

create or replace function grip_beauty.available_slots(
  p_business_id uuid,
  p_service_id uuid,
  p_local_date date,
  p_slot_step interval default interval '5 minutes'
)
returns table (
  professional_id uuid,
  professional_name text,
  slot_start_at timestamptz,
  service_ends_at timestamptz,
  blocks_until timestamptz
)
language sql
stable
as $$
  with requested_service as (
    select s.*, b.timezone
      from grip_beauty.services s
      join grip_beauty.businesses b on b.id = s.business_id
     where s.id = p_service_id
       and s.business_id = p_business_id
       and s.is_active
       and s.auto_schedule
  ),
  eligible_windows as (
    select
      p.id as professional_id,
      p.name as professional_name,
      rs.duration,
      rs.buffer,
      ((p_local_date + wh.starts_at) at time zone rs.timezone) as window_start,
      ((p_local_date + wh.ends_at) at time zone rs.timezone) as window_end
    from requested_service rs
    join grip_beauty.professional_services ps on ps.service_id = rs.id
    join grip_beauty.professionals p on p.id = ps.professional_id
    join grip_beauty.working_hours wh on wh.professional_id = p.id
    where p.business_id = p_business_id
      and p.is_active
      and wh.iso_dow = extract(isodow from p_local_date)::smallint
  ),
  candidate_slots as (
    select
      ew.professional_id,
      ew.professional_name,
      gs.slot_start_at,
      gs.slot_start_at + ew.duration as service_ends_at,
      gs.slot_start_at + ew.duration + ew.buffer as blocks_until
    from eligible_windows ew
    cross join lateral generate_series(
      ew.window_start,
      ew.window_end - ew.duration - ew.buffer,
      p_slot_step
    ) as gs(slot_start_at)
    where p_slot_step > interval '0 minutes'
  )
  select
    cs.professional_id,
    cs.professional_name,
    cs.slot_start_at,
    cs.service_ends_at,
    cs.blocks_until
  from candidate_slots cs
  where not exists (
    select 1
      from grip_beauty.calendar_blocks cb
     where cb.professional_id = cs.professional_id
       and tstzrange(cb.starts_at, cb.ends_at, '[)')
           && tstzrange(cs.slot_start_at, cs.blocks_until, '[)')
  )
    and not exists (
      select 1
        from grip_beauty.appointments a
       where a.professional_id = cs.professional_id
         and (
           a.status = 'confirmed'
           or (a.status = 'hold' and a.hold_expires_at > now())
         )
         and tstzrange(a.starts_at, a.blocks_until, '[)')
             && tstzrange(cs.slot_start_at, cs.blocks_until, '[)')
    )
  order by cs.slot_start_at, cs.professional_name;
$$;

create or replace function grip_beauty.create_hold(
  p_business_id uuid,
  p_service_id uuid,
  p_professional_id uuid,
  p_starts_at timestamptz,
  p_customer_label text default 'demo_customer'
)
returns grip_beauty.appointments
language plpgsql
as $$
declare
  v_business grip_beauty.businesses%rowtype;
  v_service grip_beauty.services%rowtype;
  v_appointment grip_beauty.appointments%rowtype;
  v_service_ends_at timestamptz;
  v_blocks_until timestamptz;
  v_now timestamptz := now();
begin
  perform pg_advisory_xact_lock(hashtextextended(p_professional_id::text, 0));

  select * into v_business
    from grip_beauty.businesses
   where id = p_business_id;

  if not found then
    raise exception 'Business % does not exist', p_business_id
      using errcode = 'P0001';
  end if;

  select * into v_service
    from grip_beauty.services
   where id = p_service_id
     and business_id = p_business_id
     and is_active;

  if not found then
    raise exception 'Service % is not active for business %', p_service_id, p_business_id
      using errcode = 'P0001';
  end if;

  if not v_service.auto_schedule then
    raise exception 'Service % requires human attention and cannot be auto-scheduled', p_service_id
      using errcode = 'P0001';
  end if;

  if not exists (
    select 1
      from grip_beauty.professionals p
      join grip_beauty.professional_services ps on ps.professional_id = p.id
     where p.id = p_professional_id
       and p.business_id = p_business_id
       and p.is_active
       and ps.service_id = p_service_id
  ) then
    raise exception 'Professional % cannot perform service %', p_professional_id, p_service_id
      using errcode = 'P0001';
  end if;

  perform grip_beauty.expire_holds(p_business_id, v_now);

  v_service_ends_at := p_starts_at + v_service.duration;
  v_blocks_until := v_service_ends_at + v_service.buffer;

  if not exists (
    select 1
      from grip_beauty.working_hours wh
     where wh.professional_id = p_professional_id
       and wh.iso_dow = extract(isodow from (p_starts_at at time zone v_business.timezone))::smallint
       and ((date(p_starts_at at time zone v_business.timezone) + wh.starts_at) at time zone v_business.timezone) <= p_starts_at
       and ((date(p_starts_at at time zone v_business.timezone) + wh.ends_at) at time zone v_business.timezone) >= v_blocks_until
  ) then
    raise exception 'Requested slot is outside working hours'
      using errcode = 'P0001';
  end if;

  if exists (
    select 1
      from grip_beauty.calendar_blocks cb
     where cb.professional_id = p_professional_id
       and tstzrange(cb.starts_at, cb.ends_at, '[)')
           && tstzrange(p_starts_at, v_blocks_until, '[)')
  ) then
    raise exception 'Requested slot overlaps a calendar block'
      using errcode = 'P0001';
  end if;

  if exists (
    select 1
      from grip_beauty.appointments a
     where a.professional_id = p_professional_id
       and a.status in ('hold', 'confirmed')
       and tstzrange(a.starts_at, a.blocks_until, '[)')
           && tstzrange(p_starts_at, v_blocks_until, '[)')
  ) then
    raise exception 'Requested slot is no longer available'
      using errcode = 'P0001';
  end if;

  insert into grip_beauty.appointments (
    business_id,
    professional_id,
    service_id,
    status,
    customer_label,
    starts_at,
    service_ends_at,
    blocks_until,
    hold_expires_at,
    created_at,
    updated_at
  )
  values (
    p_business_id,
    p_professional_id,
    p_service_id,
    'hold',
    coalesce(nullif(p_customer_label, ''), 'demo_customer'),
    p_starts_at,
    v_service_ends_at,
    v_blocks_until,
    v_now + v_business.hold_duration,
    v_now,
    v_now
  )
  returning * into v_appointment;

  return v_appointment;
end;
$$;
