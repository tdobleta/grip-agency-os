\set ON_ERROR_STOP on

do $$
declare
  v_role text;
  v_table text;
  v_function text;
  v_has_bad_privilege boolean;
begin
  foreach v_role in array array['anon', 'authenticated']
  loop
    if exists (select 1 from pg_roles where rolname = v_role) then
      foreach v_table in array array[
        'businesses',
        'professionals',
        'services',
        'professional_services',
        'working_hours',
        'calendar_blocks',
        'appointments'
      ]
      loop
        select
          has_table_privilege(v_role, format('grip_beauty.%I', v_table), 'INSERT')
          or has_table_privilege(v_role, format('grip_beauty.%I', v_table), 'UPDATE')
          or has_table_privilege(v_role, format('grip_beauty.%I', v_table), 'DELETE')
        into v_has_bad_privilege;

        if v_has_bad_privilege then
          raise exception '% has direct write privilege on grip_beauty.%', v_role, v_table;
        end if;
      end loop;

      foreach v_function in array array[
        'grip_beauty.available_slots(uuid, uuid, date, interval)',
        'grip_beauty.create_hold(uuid, uuid, uuid, timestamp with time zone, text)',
        'grip_beauty.expire_holds(uuid, timestamp with time zone)'
      ]
      loop
        if has_function_privilege(v_role, v_function, 'EXECUTE') then
          raise exception '% can execute RPC %', v_role, v_function;
        end if;
      end loop;
    end if;
  end loop;

  if exists (select 1 from pg_roles where rolname = 'service_role') then
    foreach v_function in array array[
      'grip_beauty.available_slots(uuid, uuid, date, interval)',
      'grip_beauty.create_hold(uuid, uuid, uuid, timestamp with time zone, text)',
      'grip_beauty.expire_holds(uuid, timestamp with time zone)'
    ]
    loop
      if not has_function_privilege('service_role', v_function, 'EXECUTE') then
        raise exception 'service_role cannot execute RPC %', v_function;
      end if;
    end loop;

    foreach v_table in array array[
      'businesses',
      'professionals',
      'services',
      'professional_services',
      'working_hours',
      'calendar_blocks',
      'appointments'
    ]
    loop
      if not has_table_privilege('service_role', format('grip_beauty.%I', v_table), 'SELECT') then
        raise exception 'service_role cannot select grip_beauty.%', v_table;
      end if;

      if has_table_privilege('service_role', format('grip_beauty.%I', v_table), 'DELETE') then
        raise exception 'service_role can delete grip_beauty.%', v_table;
      end if;

      if v_table = 'appointments' then
        if not has_table_privilege('service_role', 'grip_beauty.appointments', 'INSERT')
           or not has_table_privilege('service_role', 'grip_beauty.appointments', 'UPDATE') then
          raise exception 'service_role lacks INSERT/UPDATE on grip_beauty.appointments';
        end if;
      elsif has_table_privilege('service_role', format('grip_beauty.%I', v_table), 'INSERT')
         or has_table_privilege('service_role', format('grip_beauty.%I', v_table), 'UPDATE') then
        raise exception 'service_role has write privilege on grip_beauty.%', v_table;
      end if;
    end loop;
  end if;
end;
$$;

select
  'permissions_verified' as check_name,
  true as passed;

begin;

set local role service_role;

do $$
declare
  v_business_id uuid := '11111111-1111-4111-8111-111111111111';
  v_lucas_id uuid := '22222222-2222-4222-8222-222222222222';
  v_cut_id uuid := '33333333-3333-4333-8333-333333333331';
  v_cut_start timestamptz := ('2030-06-03 10:00'::timestamp at time zone 'America/Argentina/Mendoza');
  v_slot_count integer;
  v_hold grip_beauty.appointments%rowtype;
begin
  select count(*) into v_slot_count
    from grip_beauty.available_slots(v_business_id, v_cut_id, date '2030-06-03')
   where professional_id = v_lucas_id;

  if v_slot_count = 0 then
    raise exception 'service_role smoke test expected at least one available slot';
  end if;

  select * into v_hold
    from grip_beauty.create_hold(
      v_business_id,
      v_cut_id,
      v_lucas_id,
      v_cut_start,
      'Smoke Test service_role'
    );

  if v_hold.status <> 'hold' then
    raise exception 'service_role smoke test expected hold status, got %', v_hold.status;
  end if;
end;
$$;

rollback;

select
  'service_role_smoke_test_rolled_back' as check_name,
  true as passed;
