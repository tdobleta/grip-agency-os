begin;

delete from grip_beauty.appointments
 where business_id = '11111111-1111-4111-8111-111111111111';

delete from grip_beauty.calendar_blocks
 where professional_id in (
  '22222222-2222-4222-8222-222222222221',
  '22222222-2222-4222-8222-222222222222'
 );

delete from grip_beauty.working_hours
 where professional_id in (
  '22222222-2222-4222-8222-222222222221',
  '22222222-2222-4222-8222-222222222222'
 );

delete from grip_beauty.professional_services
 where professional_id in (
  '22222222-2222-4222-8222-222222222221',
  '22222222-2222-4222-8222-222222222222'
 )
    or service_id in (
  '33333333-3333-4333-8333-333333333331',
  '33333333-3333-4333-8333-333333333332',
  '33333333-3333-4333-8333-333333333333'
 );

delete from grip_beauty.services
 where business_id = '11111111-1111-4111-8111-111111111111';

delete from grip_beauty.professionals
 where business_id = '11111111-1111-4111-8111-111111111111';

delete from grip_beauty.businesses
 where id = '11111111-1111-4111-8111-111111111111';

insert into grip_beauty.businesses (
  id,
  name,
  timezone,
  plan,
  hold_duration,
  handoff_phone
)
values (
  '11111111-1111-4111-8111-111111111111',
  'Barbería Norte Demo',
  'America/Argentina/Mendoza',
  'base',
  interval '10 minutes',
  '+5492610000000'
);

insert into grip_beauty.professionals (id, business_id, name)
values
  (
    '22222222-2222-4222-8222-222222222221',
    '11111111-1111-4111-8111-111111111111',
    'Juan'
  ),
  (
    '22222222-2222-4222-8222-222222222222',
    '11111111-1111-4111-8111-111111111111',
    'Lucas'
  );

insert into grip_beauty.services (
  id,
  business_id,
  name,
  price_ars,
  duration,
  buffer,
  deposit_ars
)
values
  (
    '33333333-3333-4333-8333-333333333331',
    '11111111-1111-4111-8111-111111111111',
    'Corte clásico',
    18000,
    interval '30 minutes',
    interval '5 minutes',
    5000
  ),
  (
    '33333333-3333-4333-8333-333333333332',
    '11111111-1111-4111-8111-111111111111',
    'Corte + barba',
    25000,
    interval '45 minutes',
    interval '5 minutes',
    7000
  ),
  (
    '33333333-3333-4333-8333-333333333333',
    '11111111-1111-4111-8111-111111111111',
    'Coloración',
    45000,
    interval '90 minutes',
    interval '15 minutes',
    15000
  );

insert into grip_beauty.professional_services (professional_id, service_id)
values
  (
    '22222222-2222-4222-8222-222222222221',
    '33333333-3333-4333-8333-333333333331'
  ),
  (
    '22222222-2222-4222-8222-222222222221',
    '33333333-3333-4333-8333-333333333332'
  ),
  (
    '22222222-2222-4222-8222-222222222222',
    '33333333-3333-4333-8333-333333333331'
  ),
  (
    '22222222-2222-4222-8222-222222222222',
    '33333333-3333-4333-8333-333333333333'
  );

insert into grip_beauty.working_hours (professional_id, iso_dow, starts_at, ends_at)
select
  '22222222-2222-4222-8222-222222222221',
  dow,
  start_time,
  end_time
from generate_series(1, 6) as dow
cross join (
  values
    (time '09:00', time '13:00'),
    (time '15:00', time '19:00')
) as shifts(start_time, end_time);

insert into grip_beauty.working_hours (professional_id, iso_dow, starts_at, ends_at)
select
  '22222222-2222-4222-8222-222222222222',
  dow,
  time '10:00',
  time '18:00'
from generate_series(1, 6) as dow;

insert into grip_beauty.calendar_blocks (
  professional_id,
  starts_at,
  ends_at,
  reason
)
values (
  '22222222-2222-4222-8222-222222222221',
  ('2030-06-03 13:00'::timestamp at time zone 'America/Argentina/Mendoza'),
  ('2030-06-03 15:00'::timestamp at time zone 'America/Argentina/Mendoza'),
  'Bloqueo demo TASK 01'
);

commit;
