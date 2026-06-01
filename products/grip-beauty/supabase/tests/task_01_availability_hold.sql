\set ON_ERROR_STOP on

begin;

do $$
declare
  v_business_id uuid := '11111111-1111-4111-8111-111111111111';
  v_lucas_id uuid := '22222222-2222-4222-8222-222222222222';
  v_cut_id uuid := '33333333-3333-4333-8333-333333333331';
  v_color_id uuid := '33333333-3333-4333-8333-333333333333';
  v_cut_start timestamptz := ('2030-06-03 10:00'::timestamp at time zone 'America/Argentina/Mendoza');
  v_color_last_valid timestamptz := ('2030-06-03 16:15'::timestamp at time zone 'America/Argentina/Mendoza');
  v_color_too_late timestamptz := ('2030-06-03 16:20'::timestamp at time zone 'America/Argentina/Mendoza');
  v_slot_count integer;
  v_hold grip_beauty.appointments%rowtype;
  v_duplicate_was_rejected boolean := false;
  v_expired_count integer;
begin
  select count(*) into v_slot_count
    from grip_beauty.available_slots(v_business_id, v_cut_id, date '2030-06-03')
   where professional_id = v_lucas_id
     and slot_start_at = v_cut_start
     and service_ends_at = v_cut_start + interval '30 minutes'
     and blocks_until = v_cut_start + interval '35 minutes';

  if v_slot_count <> 1 then
    raise exception 'Expected Corte clasico slot with 30 minutes plus 5 minute buffer, got %', v_slot_count;
  end if;

  select * into v_hold
    from grip_beauty.create_hold(
      v_business_id,
      v_cut_id,
      v_lucas_id,
      v_cut_start,
      'demo_acceptance_test'
    );

  if v_hold.status <> 'hold'
     or v_hold.hold_expires_at <> v_hold.created_at + interval '10 minutes'
     or v_hold.blocks_until <> v_cut_start + interval '35 minutes' then
    raise exception 'Created hold does not match expected 10 minute expiration or buffered range';
  end if;

  begin
    perform grip_beauty.create_hold(
      v_business_id,
      v_cut_id,
      v_lucas_id,
      v_cut_start,
      'demo_duplicate_test'
    );
  exception
    when others then
      v_duplicate_was_rejected := true;
  end;

  if not v_duplicate_was_rejected then
    raise exception 'Expected overlapping second hold to be rejected';
  end if;

  select count(*) into v_slot_count
    from grip_beauty.available_slots(v_business_id, v_cut_id, date '2030-06-03')
   where professional_id = v_lucas_id
     and slot_start_at = v_cut_start;

  if v_slot_count <> 0 then
    raise exception 'Expected held slot to disappear while hold is active, got %', v_slot_count;
  end if;

  update grip_beauty.appointments
     set hold_expires_at = now() - interval '1 second'
   where id = v_hold.id;

  select grip_beauty.expire_holds(v_business_id) into v_expired_count;

  if v_expired_count <> 1 then
    raise exception 'Expected one expired hold, got %', v_expired_count;
  end if;

  select count(*) into v_slot_count
    from grip_beauty.available_slots(v_business_id, v_cut_id, date '2030-06-03')
   where professional_id = v_lucas_id
     and slot_start_at = v_cut_start;

  if v_slot_count <> 1 then
    raise exception 'Expected slot to return after hold expiration, got %', v_slot_count;
  end if;

  select count(*) into v_slot_count
    from grip_beauty.available_slots(v_business_id, v_color_id, date '2030-06-03')
   where professional_id = v_lucas_id
     and slot_start_at = v_color_last_valid
     and service_ends_at = v_color_last_valid + interval '90 minutes'
     and blocks_until = v_color_last_valid + interval '105 minutes';

  if v_slot_count <> 1 then
    raise exception 'Expected Coloracion to allow last slot fitting 90 minutes plus 15 minute buffer, got %', v_slot_count;
  end if;

  select count(*) into v_slot_count
    from grip_beauty.available_slots(v_business_id, v_color_id, date '2030-06-03')
   where professional_id = v_lucas_id
     and slot_start_at = v_color_too_late;

  if v_slot_count <> 0 then
    raise exception 'Expected Coloracion slot exceeding 90 minutes plus 15 minute buffer to be absent, got %', v_slot_count;
  end if;
end;
$$;

rollback;
