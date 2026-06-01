# BAR-CORE-01 - Availability and Hold

Workflow manual de n8n para probar el nucleo aprobado de TASK 01 con datos ficticios. Consulta disponibilidad con `grip_beauty.available_slots(...)`, verifica un horario elegido y crea un hold de 10 minutos con `grip_beauty.create_hold(...)`.

No conecta WhatsApp, Mercado Pago, Google Calendar, Claude ni funciones Premium.

## Credencial de n8n

Configurar manualmente en n8n variables o credencial backend privada para Supabase:

- `SUPABASE_PROJECT_URL`: URL del proyecto Supabase.
- `SUPABASE_BACKEND_API_KEY`: clave privada backend guardada en n8n. No debe copiarse al JSON, al repositorio, al frontend ni a exports publicos.

El workflow usa HTTP Request hacia Supabase RPC con headers `Content-Profile` y `Accept-Profile` en `grip_beauty`.

## Importar

1. Abrir n8n.
2. Importar `products/grip-beauty/n8n/BAR-CORE-01_Availability_and_Hold.json`.
3. Confirmar que las variables o credenciales backend esten disponibles para los nodos HTTP Request.
4. Mantener el workflow desactivado; ejecutarlo solo manualmente para demo.

## Test manual

Antes del primer run, aplicar en Supabase:

1. `products/grip-beauty/supabase/migrations/202606010001_task_01_availability_hold.sql`
2. `products/grip-beauty/supabase/seed_task_01_demo.sql`
3. `products/grip-beauty/supabase/migrations/202606010002_task_02_rpc_access_hardening.sql`

Ejecutar manualmente el workflow con el input demo ya cargado:

- `business_id`: `11111111-1111-4111-8111-111111111111`
- `service_id`: `33333333-3333-4333-8333-333333333331`
- `professional_id`: `22222222-2222-4222-8222-222222222222`
- `date`: `2030-06-03`
- `selected_start_at`: `2030-06-03T10:00:00-03:00`
- `customer_label`: `Cliente Demo n8n`

Resultado esperado del primer run:

- Se listan slots disponibles.
- El slot seleccionado esta disponible.
- Se crea un hold con `status = hold`.
- La salida final incluye `appointment_id`, `status`, `professional_id`, `service_id`, `starts_at`, `blocks_until` y `hold_expires_at`.

## Segundo run

Ejecutar de nuevo el mismo workflow antes de que pasen 10 minutos. El mismo slot debe dejar de aparecer como disponible y el flujo debe devolver `status = slot_not_available`.

Si se ejecuta despues de expirar el hold, correr primero `grip_beauty.expire_holds(...)` o esperar el mecanismo operativo de expiracion configurado para la demo.

## Seguridad

- n8n debe usar las RPCs; no debe escribir directo en tablas internas.
- Las tablas internas no deben exponerse a escritura directa desde clientes o frontend.
- Las credenciales privadas de Supabase quedan solo en n8n/backend seguro.
- No activar este workflow con APIs reales todavia.
