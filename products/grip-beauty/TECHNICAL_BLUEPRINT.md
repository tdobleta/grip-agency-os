# GRIP Barberías/Peluquerías — Blueprint técnico v1

**Estado:** Listo para implementación controlada del demo Base  
**Fecha:** 2026-06-01  
**Objetivo:** construir un sistema profesional de reservas con seña sin complicar la operación del cliente ni la entrega de GRIP.

## 1. Principios de construcción

1. **Un solo sistema configurable.** Base, Premium y Full Deluxe comparten arquitectura; las funciones se habilitan por cliente.
2. **El dueño usa herramientas conocidas.** WhatsApp para atención, Mercado Pago para cobrar, Google Calendar para visualizar turnos y bloquear excepciones.
3. **Supabase es invisible.** Se usa únicamente para asegurar configuración, holds, reservas, pagos y consistencia.
4. **n8n orquesta; no decide finanzas.** El workflow llama reglas determinísticas y reacciona a webhooks.
5. **Claude interpreta conversación; no confirma turnos ni pagos.**
6. **Primero Base completo.** Premium se implementa después de que el flujo de reserva + seña esté probado punta a punta.
7. **Sin credenciales reales en repositorio ni demo inicial.**

## 2. Alcance de implementación inmediata

### Incluido en el demo Base

- negocio ficticio de barbería;
- profesionales, servicios, duración y buffer;
- disponibilidad real;
- hold de turno por 10 minutos;
- referencia de pago vinculada al hold;
- confirmación idempotente de pago aprobado;
- turno confirmado en Google Calendar de demo;
- notificación de confirmación y ruta de derivación humana;
- configuración Base/Premium/Full Deluxe preparada, aunque Premium quede apagado.

### No incluido todavía

- WhatsApp productivo de un cliente;
- Mercado Pago productivo;
- campañas, reseñas o rebooking reales;
- bot telefónico;
- página web Full Deluxe;
- panel propio para el dueño.

## 3. Herramientas

| Herramienta | Uso inmediato | Regla |
|---|---|---|
| n8n | Ejecutar workflows | Un proyecto/carpeta `GRIP / Barberías` |
| Supabase/Postgres | Fuente segura de reservas y pagos | No exponer service role en frontend ni workflows exportados públicos |
| Mercado Pago Checkout Pro | Crear la seña | Link/prefencia alineado al vencimiento del hold |
| Google Calendar | Agenda visible | Solo turno confirmado y bloqueos del dueño; no es el ledger de pago |
| WhatsApp Business Cloud | Canal final | Se conecta después de probar el núcleo |
| Claude | Intención y lenguaje | Nunca decide estado de pago o reserva |

## 4. Datos mínimos del núcleo

No hace falta construir un SaaS. Solo necesitamos estas entidades internas.

### `businesses`

Configuración del cliente y toggles del plan.

Campos mínimos:

- `id`
- `name`
- `timezone` (`America/Argentina/Mendoza` para demo)
- `plan` (`base`, `premium`, `full_deluxe`)
- `whatsapp_human_handoff_number`
- `hold_minutes` (default `10`)
- `reminders_enabled`
- `reviews_enabled`
- `rebooking_enabled`
- `reports_enabled`
- `website_included`

### `professionals`

- `id`, `business_id`, `name`, `active`

### `services`

- `id`, `business_id`, `name`, `price_amount`
- `duration_minutes`
- `buffer_minutes`
- `deposit_amount` o regla equivalente
- `auto_bookable`
- `active`

### `professional_services`

Relaciona quién puede realizar cada servicio.

### `working_hours` y `calendar_blocks`

Disponibilidad recurrente y bloqueos manuales/excepcionales.

### `appointments`

Reserva temporal o confirmada.

Campos mínimos:

- `id`, `business_id`, `professional_id`, `service_id`
- `customer_name`, `customer_phone`
- `start_at`, `end_at`
- `status` (`hold`, `confirmed`, `expired`, `cancelled`, `needs_human_review`)
- `hold_expires_at`
- `payment_reference`
- `calendar_event_id`
- `created_at`, `confirmed_at`

### `payment_events`

Registro de eventos de Mercado Pago para confirmar una sola vez.

Campos mínimos:

- `id`, `appointment_id`, `provider`, `provider_payment_id`
- `status`, `received_at`, `raw_event_id`
- unicidad por identificador externo procesado

## 5. Reglas no negociables

### Disponibilidad

Un horario se puede ofrecer solo si:

- el servicio es reservable automáticamente;
- existe un profesional habilitado;
- cabe completo dentro de su horario de trabajo;
- duración + buffer no se superpone con bloqueos, holds vigentes ni turnos confirmados;
- cumple anticipación mínima/máxima definida por negocio.

### Hold

- se crea únicamente si el horario sigue disponible al momento de elegirlo;
- dura 10 minutos en la configuración inicial;
- debe impedir otro hold o confirmación superpuesta;
- si vence sin pago aprobado, pasa a `expired` y libera el horario.

### Pago

- la preferencia/link de seña debe vencer junto con el hold;
- el cliente no confirma mediante captura o mensaje;
- solo un evento confiable de Mercado Pago con estado aprobado puede confirmar;
- procesar el mismo webhook más de una vez no debe duplicar reserva, Calendar ni mensajes.

### Calendar

- se crea evento definitivo solo tras confirmación de pago;
- el evento debe identificar servicio, profesional, cliente y estado confirmado;
- si Calendar falla después de pago aprobado, la reserva queda confirmada internamente y se genera alerta para resolver, nunca se pierde el pago.

### Derivación humana

El sistema deriva, sin decidir automáticamente, cuando:

- hay reclamo o duda sobre pago;
- el cliente afirma haber pagado fuera de plazo;
- solicita un servicio marcado como no reservable;
- la política del negocio requiere aprobación;
- falla una integración crítica.

## 6. Workflows n8n de la primera construcción

| Orden | Workflow | Se construye ahora | Función |
|---:|---|---:|---|
| 1 | `BAR-CORE-01_Availability_and_Hold` | Sí | Recibe datos de prueba, consulta disponibilidad y crea hold |
| 2 | `BAR-CORE-02_Expire_Holds` | Sí | Marca vencidos y libera horarios |
| 3 | `BAR-CORE-03_Confirm_Payment` | Sí | Simula/recibe pago aprobado e idempotentemente confirma |
| 4 | `BAR-CORE-04_Calendar_Confirmed` | Sí | Crea evento en Calendar demo luego de confirmación |
| 5 | `BAR-CORE-99_Errors_Handoff` | Sí | Registra alertas y ruta a humano |
| 6 | `BAR-CHAT-01_WhatsApp_Entry` | Después | Mensajería real y Claude |
| 7 | `BAR-PREMIUM-01_Reminders` | Después | Función Premium |
| 8 | `BAR-PREMIUM-02_Reviews_Rebooking` | Después | Función Premium |

## 7. Orden de ejecución sin vueltas

### Paso 1 — Núcleo de datos

Crear el esquema mínimo y cargar una barbería ficticia con dos profesionales y tres servicios.

### Paso 2 — Disponibilidad + hold

Construir y probar el primer workflow/manual trigger: seleccionar servicio/horario y crear un hold válido; un segundo intento sobre el mismo horario debe fallar controladamente.

### Paso 3 — Expiración

Probar que el hold vence a los 10 minutos y vuelve a aparecer como disponible.

### Paso 4 — Pago de prueba

Integrar/simular evento de pago aprobado; confirmar solo una vez y rechazar confirmación tardía.

### Paso 5 — Google Calendar demo

Crear evento únicamente para la cita confirmada.

### Paso 6 — WhatsApp

Conectar WhatsApp y Claude solo cuando los cinco pasos anteriores funcionen.

## 8. Pruebas de aceptación Base

| Caso | Resultado obligatorio |
|---|---|
| Consulta de disponibilidad válida | Ofrece solo slots que caben por duración + buffer |
| Dos intentos mismo profesional/hora | Solo uno obtiene hold |
| Hold sin pago | Expira y libera horario |
| Link/evento de pago vencido | No confirma turno automáticamente; deriva |
| Pago aprobado en plazo | Confirma una sola reserva |
| Webhook duplicado | No duplica confirmación ni evento Calendar |
| Calendar falla tras pago | Se alerta; la reserva interna permanece confirmada |
| Servicio no auto-reservable | Deriva a humano |
| Plan Base | No dispara módulos Premium |

## 9. Primera tarea para Codex/n8n

Implementar únicamente `BAR-CORE-01_Availability_and_Hold` sobre datos ficticios y dejar evidencia de estas pruebas:

1. devuelve horarios libres para un servicio;
2. crea un hold de 10 minutos;
3. bloquea un segundo hold superpuesto;
4. no toca WhatsApp real ni Mercado Pago real;
5. no construye Premium todavía.

Esta tarea es el primer punto ejecutable del vertical. Si funciona, GRIP ya tiene el motor que diferencia una demo profesional de un bot improvisado.
