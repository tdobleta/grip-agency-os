-- TASK 02: hardening minimo para ejecutar RPCs desde un backend seguro.
-- Modelo demo:
-- - n8n usa una credencial backend privada de Supabase.
-- - n8n llama solo RPCs del schema grip_beauty.
-- - Las tablas internas no se exponen para escritura directa a anon/authenticated.
-- - La credencial service_role no debe aparecer en frontend, archivos del repo ni exports publicos.

do $$
declare
  v_role text;
  v_backend_role text;
begin
  foreach v_role in array array['anon', 'authenticated']
  loop
    if exists (select 1 from pg_roles where rolname = v_role) then
      execute format('revoke all on schema grip_beauty from %I', v_role);
      execute format('revoke all on all tables in schema grip_beauty from %I', v_role);
      execute format('revoke all on all sequences in schema grip_beauty from %I', v_role);
      execute format('revoke all on all functions in schema grip_beauty from %I', v_role);

      execute format(
        'revoke insert, update, delete on table %s from %I',
        'grip_beauty.businesses, grip_beauty.professionals, grip_beauty.services, grip_beauty.professional_services, grip_beauty.working_hours, grip_beauty.calendar_blocks, grip_beauty.appointments',
        v_role
      );
    end if;
  end loop;

  revoke all on schema grip_beauty from public;
  revoke all on all tables in schema grip_beauty from public;
  revoke all on all sequences in schema grip_beauty from public;
  revoke all on all functions in schema grip_beauty from public;

  execute format(
    'alter default privileges for role %I in schema grip_beauty revoke execute on functions from public',
    current_user
  );

  foreach v_role in array array['anon', 'authenticated']
  loop
    if exists (select 1 from pg_roles where rolname = v_role) then
      execute format(
        'alter default privileges for role %I in schema grip_beauty revoke execute on functions from %I',
        current_user,
        v_role
      );
    end if;
  end loop;

  foreach v_backend_role in array array['service_role', 'postgres']
  loop
    if exists (select 1 from pg_roles where rolname = v_backend_role) then
      execute format('grant usage on schema grip_beauty to %I', v_backend_role);
      execute format(
        'grant execute on function grip_beauty.available_slots(uuid, uuid, date, interval) to %I',
        v_backend_role
      );
      execute format(
        'grant execute on function grip_beauty.create_hold(uuid, uuid, uuid, timestamptz, text) to %I',
        v_backend_role
      );
      execute format(
        'grant execute on function grip_beauty.expire_holds(uuid, timestamptz) to %I',
        v_backend_role
      );

      if v_backend_role = 'service_role' then
        execute format(
          'grant select on table %s to %I',
          'grip_beauty.businesses, grip_beauty.professionals, grip_beauty.services, grip_beauty.professional_services, grip_beauty.working_hours, grip_beauty.calendar_blocks, grip_beauty.appointments',
          v_backend_role
        );
        execute format(
          'grant insert, update on table grip_beauty.appointments to %I',
          v_backend_role
        );
        execute format(
          'revoke delete on table grip_beauty.appointments from %I',
          v_backend_role
        );
      end if;
    end if;
  end loop;
end;
$$;
