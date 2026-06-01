# GRIP Barberías/Peluquerías — Blueprint técnico v1

**Estado:** listo para construir el demo Base  
**Fecha:** 2026-06-01

## Objetivo

Construir una automatización profesional pero simple: el cliente consulta por WhatsApp, elige un turno real, paga una seña dentro de 10 minutos y recién entonces la reserva aparece confirmada en la agenda del dueño.

## Regla de simplicidad

El cliente solo manejará:

- WhatsApp para atender/reservar;
- Mercado Pago para cobrar;
- Google Calendar para ver turnos y bloquear excepciones.

GRIP manejará por detrás n8n y una base mínima Supabase/Postgres para que no haya dobles reservas ni confirmaciones falsas.

## Stack elegido

| Pieza | Función |
|---|---|
| WhatsApp Business Cloud | Canal con el cliente final |
| n8n | Ejecuta los flujos y conecta herramientas |
| Claude | Interpreta mensajes y redacta; nunca confirma pagos o reservas |
| Supabase/Postgres | Configuración, horarios, holds, reservas y pagos |
| Mercado Pago Checkout Pro | Link de seña con vencimiento de 10 minutos |
| Google Calendar | Agenda visible; solo recibe turnos confirmados y bloqueos manuales |

## Un sistema, tres planes

| Plan | Módulos activos |
|---|---|
| Base | Reserva + seña + confirmación + Calendar + derivación |
| Premium | Base + recordatorios + reseñas + rebooking + reporte |
| Full Deluxe | Premium + página web, coordinada por WhatsApp |

No se duplican workflows: se activan o desactivan funciones por negocio.

## Datos mínimos internos

Solo hacen falta estas entidades:

- `businesses`: negocio, plan, número de derivación, hold de 10 min y toggles.
- `professionals`: profesionales del negocio.
- `services`: servicio, duración, buffer, precio, seña y si se agenda automáticamente.
- `professional_services`: qué servicio realiza cada profesional.
- `working_hours`: horario habitual.
- `calendar_blocks`: bloqueos/ausencias/excepciones.
- `appointments`: holds y turnos confirmados/cancelados.
- `payment_events`: eventos procesados de Mercado Pago para evitar duplicados.

Estados mínimos de `appointments`:

- `hold`
- `confirmed`
- `expired`
- `cancelled`
- `needs_human_review`

## Reglas críticas

### Disponibilidad

Un horario solo se ofrece cuando existe un profesional habilitado y libre durante **duración del servicio + buffer**, dentro de su horario, sin bloqueo, turno confirmado ni hold vigente.

### Hold de seña

- El horario se bloquea 10 minutos cuando el cliente lo elige.
- Otro cliente no puede tomarlo mientras el hold está vigente.
- Si no entra el pago a tiempo, expira y el horario vuelve a estar libre.

### Pago

- El link de Mercado Pago vence junto con el hold.
- Solo un webhook aprobado y validado confirma el turno.
- Un webhook repetido no puede duplicar la confirmación.
- Pago fuera de plazo o reclamo: derivar a humano.

### Google Calendar

- Calendar no controla el pago ni el hold.
- Solo se crea el turno visible después de pago confirmado.
- Si Calendar falla después de cobrar, la reserva interna queda confirmada y se genera alerta; nunca se pierde la trazabilidad del pago.

## Orden de construcción

1. `BAR-CORE-01_Availability_and_Hold`: disponibilidad y hold sobre datos ficticios.
2. `BAR-CORE-02_Expire_Holds`: liberar holds vencidos.
3. `BAR-CORE-03_Confirm_Payment`: confirmar una sola vez con pago simulado/webhook de prueba.
4. `BAR-CORE-04_Calendar_Confirmed`: crear evento en Calendar demo.
5. `BAR-CORE-99_Errors_Handoff`: alertar/derivar casos humanos.
6. Recién después: WhatsApp + Claude.
7. Recién después: Premium y Full Deluxe.

## Qué no se construye ahora

- WhatsApp o Mercado Pago productivo.
- Página web.
- Bot telefónico.
- Dashboard para el dueño.
- Otros verticales.

## Demo vendible Base: condiciones de cierre

La demo queda lista solo si demuestra:

- disponibilidad según duración + buffer;
- un hold válido de 10 minutos;
- rechazo de doble reserva sobre el mismo turno;
- liberación tras vencer sin pago;
- confirmación única de pago aprobado;
- un único evento confirmado en Calendar;
- derivación humana ante incidente o servicio especial.
