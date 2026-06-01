\set ON_ERROR_STOP on

with table_permissions as (
  select
    role_name,
    table_name,
    has_table_privilege(role_name, format('grip_beauty.%I', table_name), 'INSERT') as can_insert,
    has_table_privilege(role_name, format('grip_beauty.%I', table_name), 'UPDATE') as can_update,
    has_table_privilege(role_name, format('grip_beauty.%I', table_name), 'DELETE') as can_delete
  from unnest(array['anon', 'authenticated']) as roles(role_name)
  cross join unnest(array[
    'businesses',
    'professionals',
    'services',
    'professional_services',
    'working_hours',
    'calendar_blocks',
    'appointments'
  ]) as tables(table_name)
  where exists (select 1 from pg_roles where rolname = role_name)
),
function_permissions as (
  select
    role_name,
    function_signature,
    has_function_privilege(role_name, function_signature, 'EXECUTE') as can_execute
  from unnest(array['anon', 'authenticated', 'service_role']) as roles(role_name)
  cross join unnest(array[
    'grip_beauty.available_slots(uuid, uuid, date, interval)',
    'grip_beauty.create_hold(uuid, uuid, uuid, timestamp with time zone, text)',
    'grip_beauty.expire_holds(uuid, timestamp with time zone)'
  ]) as functions(function_signature)
  where exists (select 1 from pg_roles where rolname = role_name)
)
select
  'table_write_permissions' as check_name,
  role_name,
  table_name as object_name,
  can_insert,
  can_update,
  can_delete,
  null::boolean as can_execute
from table_permissions
union all
select
  'rpc_execute_permissions' as check_name,
  role_name,
  function_signature as object_name,
  null::boolean as can_insert,
  null::boolean as can_update,
  null::boolean as can_delete,
  can_execute
from function_permissions
order by check_name, role_name, object_name;

-- Expected Supabase results:
-- - anon/authenticated table can_insert/can_update/can_delete are all false.
-- - anon/authenticated RPC can_execute is false.
-- - service_role RPC can_execute is true.
