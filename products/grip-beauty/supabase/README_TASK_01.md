# TASK 01 - Disponibilidad + Hold Seguro

Este paquete contiene el núcleo Supabase/Postgres para la barbería demo de GRIP Beauty.

## Archivos

- `migrations/202606010001_task_01_availability_hold.sql`: esquema mínimo, constraints y RPCs.
- `seed_task_01_demo.sql`: datos ficticios de Barberia Norte Demo.
- `tests/task_01_availability_hold.sql`: pruebas SQL reproducibles.

## Ejecutar en Supabase/Postgres

Desde una base Postgres compatible con Supabase:

```bash
psql -U postgres -d grip_beauty_task01_test \
  -f products/grip-beauty/supabase/migrations/202606010001_task_01_availability_hold.sql \
  -f products/grip-beauty/supabase/seed_task_01_demo.sql \
  -f products/grip-beauty/supabase/tests/task_01_availability_hold.sql
```

En Supabase SQL Editor, ejecutar los tres archivos en el mismo orden.

## RPCs

- `grip_beauty.available_slots(p_business_id, p_service_id, p_local_date, p_slot_step)`: devuelve horarios disponibles por profesional. Cada slot considera duracion del servicio mas buffer.
- `grip_beauty.create_hold(p_business_id, p_service_id, p_professional_id, p_starts_at, p_customer_label)`: crea un hold atómico por la duración configurada del negocio.
- `grip_beauty.expire_holds(p_business_id, p_reference_at)`: marca como `expired` los holds vencidos y devuelve la cantidad actualizada.

## Seguridad de ejecución futura

- n8n deberá usar estas funciones/RPCs y no inserts directos sobre tablas internas.
- Las tablas internas no deben exponerse a escritura directa desde clientes o frontend.
- Las credenciales privadas de Supabase quedarán únicamente en n8n o en un backend seguro.
- El hardening de permisos Supabase se aplicará antes de conectar APIs reales. No se diseña RLS complejo en TASK 01.

## Expiración de holds

La RPC `create_hold` ejecuta `expire_holds` dentro de la misma transacción antes de insertar, así un hold vencido no sigue bloqueando nuevos holds. Para limpieza operativa, programar `grip_beauty.expire_holds(null, now())` cada minuto con Supabase Scheduled Functions, pg_cron o un workflow n8n interno.

## Datos demo

- Negocio: `Barbería Norte Demo`
- Timezone: `America/Argentina/Mendoza`
- Plan: `base`
- Hold: `10 minutes`
- Teléfono ficticio de derivación: `+5492610000000`
- Profesionales: `Juan`, `Lucas`
- Servicios: `Corte clásico`, `Corte + barba`, `Coloración`, `Coloración especial con evaluación`
- Bloqueo demo: Juan, `2030-06-03 13:00-15:00`

Todos los datos son ficticios y no contienen credenciales.
