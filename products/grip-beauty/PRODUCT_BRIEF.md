# GRIP — Barberías y Peluquerías: Reservas + Seña v1.0

**Estado:** Primer paquete vertical ejecutable / en construcción controlada  
**Vertical:** Barberías y peluquerías  
**Decisión vigente:** 2026-06-01

## 1. Posición dentro de GRIP

GRIP es una agencia de automatizaciones aplicables a distintos rubros. Barberías/Peluquerías será el **primer vertical ejecutable como paquete completo**, porque sus reglas operativas ya están definidas y la propuesta es directa de vender.

El dueño no compra una plataforma para configurar por su cuenta. Contrata una automatización instalada por GRIP que atiende por WhatsApp, ofrece turnos reales, cobra una seña y confirma la reserva automáticamente.

## 2. Promesa comercial central

> Tu WhatsApp atiende consultas, ofrece turnos reales, cobra la seña y confirma la reserva automáticamente, mientras vos seguís trabajando.

## 3. Planes del vertical

| Plan | Funciones activas |
|---|---|
| **Base — Reservas + Seña** | Consultas básicas, disponibilidad, reserva temporal de 10 minutos, seña Mercado Pago, confirmación, Google Calendar, cancelación/reprogramación según política y derivación humana |
| **Premium** | Todo Base + recordatorios, pedido de reseña, rebooking y reporte mensual según configuración del cliente |
| **Full Deluxe** | Todo Premium + página web personalizada, relevada por conversación directa con GRIP |

La arquitectura es única. Los planes se habilitan mediante configuración por cliente; no se duplican workflows.

## 4. Regla operativa central

La disponibilidad solo existe cuando hay un profesional habilitado, libre durante la duración del servicio más su buffer, dentro de su horario, sin bloqueos manuales, sin turno confirmado y sin reserva temporal vigente.

### Reserva y seña

1. El cliente selecciona un servicio y horario disponible.
2. El sistema crea un bloqueo temporal (`hold`) por **10 minutos**.
3. Se genera un link de pago de seña con el mismo vencimiento.
4. Mientras existe el hold, ese horario no se ofrece a otra persona.
5. Si el pago se acredita y valida dentro del plazo, el turno se confirma.
6. Si vence el plazo, se libera el horario y el link deja de estar disponible.
7. Si el cliente informa un problema de pago o afirma haber pagado fuera de plazo, el bot no confirma nada: deriva al responsable.

## 5. Flujo Base que se construirá primero

```text
WhatsApp entrante
 -> identificar intención y servicio
 -> consultar disponibilidad real
 -> cliente elige horario/profesional
 -> crear hold de 10 minutos
 -> crear link de seña Mercado Pago con vencimiento alineado
 -> validar pago aprobado por webhook
 -> confirmar reserva
 -> crear turno confirmado en Google Calendar
 -> notificar cliente y responsable
```

Claude puede interpretar texto y redactar respuestas; no decide pagos, confirmaciones ni disponibilidad final.

## 6. Arquitectura elegida

| Componente | Responsabilidad |
|---|---|
| WhatsApp Business Cloud | Canal de conversación |
| n8n | Orquestación de workflows y conexiones |
| Claude | Clasificación de intención y redacción conversacional |
| Supabase/Postgres | Configuración, profesionales, servicios, holds, reservas, pagos y control de conflicto |
| Mercado Pago Checkout Pro | Link de seña con vigencia limitada y notificaciones de pago |
| Google Calendar | Agenda visible del dueño para turnos confirmados y bloqueos operativos |

Supabase es backend invisible para el cliente; no se entrega un dashboard propio en esta etapa.

## 7. Por qué no Calendar solo

Calendar sigue siendo la agenda visible, pero no debe ser la única fuente de control para holds y pagos. El sistema necesita identificar reservas temporales, impedir conflictos, registrar la asociación pago-reserva y procesar webhooks de forma idempotente.

## 8. Alcance fuera de la primera construcción

- Bot de reservas por llamadas telefónicas: módulo adicional futuro; el formulario solo detecta interés.
- Página web Full Deluxe: se releva por WhatsApp, no dentro del formulario operativo.
- Dashboard propio para el cliente: no corresponde a esta fase.
- Múltiples verticales en paralelo: se trabaja primero este vertical hasta obtener demo y primera instalación estable.

## 9. Condición de demo vendible

El demo se considera listo cuando, con un negocio ficticio, prueba de punta a punta:

- consulta de servicio y disponibilidad;
- bloqueo real de un horario durante 10 minutos;
- rechazo de un segundo intento sobre el mismo horario;
- vencimiento/liberación sin pago;
- pago aprobado validado una sola vez;
- creación de un único turno confirmado en Calendar;
- derivación humana ante incidente de pago o caso especial.

## 10. Documentación operativa aprobada

El formulario oficial de instalación del vertical ya fue definido por GRIP. Recolecta datos del responsable, estructura operativa, profesionales, servicios, duración y buffers, reglas de agenda, señas, cancelaciones/reprogramaciones, derivación, plan contratado y herramientas disponibles.
