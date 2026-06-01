# TASK 01 — Disponibilidad + Hold Seguro

**Vertical:** Barberías/Peluquerías  
**Núcleo compartido:** Base, Premium y Full Deluxe  
**Estado:** Listo para ejecutar con Claude Code  
**Alcance:** solo datos ficticios + Supabase/Postgres + pruebas reproducibles.

## Objetivo

Crear el primer componente real de GRIP: consultar horarios disponibles para un servicio y bloquear un turno elegido durante 10 minutos, impidiendo que otra reserva tome el mismo profesional y horario.

## No construir todavía

- WhatsApp real.
- Mercado Pago real.
- Google Calendar real.
- Claude conversacional.
- Recordatorios, reseñas o rebooking.
- Página web o reservas por llamada.

## Demo ficticia a cargar

### Negocio

- Nombre: `Barbería Norte Demo`
- Zona horaria: `America/Argentina/Mendoza`
- Plan: `base`
- Duración de hold: `10 minutos`
- Número de derivación ficticio: `+5492610000000`

### Profesionales

| Profesional | Horario inicial de demo | Servicios |
|---|---|---|
| Juan | Lun-Sáb 09:00-13:00 / 15:00-19:00 | Corte clásico, Corte + barba |
| Lucas | Lun-Sáb 10:00-18:00 | Corte clásico, Coloración |

### Servicios

| Servicio | Precio demo ARS | Duración | Buffer | Seña demo ARS |
|---|---:|---:|---:|---:|
| Corte clásico | 18.000 | 30 min | 5 min | 5.000 |
| Corte + barba | 25.000 | 45 min | 5 min | 7.000 |
| Coloración | 45.000 | 90 min | 15 min | 15.000 |

### Bloqueo de ejemplo

- Bloquear a Juan en una fecha futura de prueba entre `13:00` y `15:00`.

## Reglas que la implementación debe cumplir

1. El slot se calcula usando `duración + buffer`.
2. Un `hold` vigente bloquea igual que una reserva confirmada.
3. Un `hold` vencido deja de bloquear.
4. Crear el hold debe ser atómico: dos intentos superpuestos no pueden ganar ambos.
5. No debe confiarse la prevención de doble reserva a n8n ni a Calendar; debe garantizarla Postgres.
6. La lógica debe exponerse de forma que n8n pueda llamarla después, preferentemente mediante funciones/RPCs claras.
7. No guardar credenciales ni datos reales.

## Entregables mínimos

Antes de crear archivos, inspeccionar la estructura actual del repositorio y mantener la convención existente. Entregar:

1. Migración SQL del esquema mínimo requerido para TASK 01.
2. Seed SQL de la barbería demo.
3. Función/RPC para consultar disponibilidad.
4. Función/RPC transaccional para crear hold de 10 minutos.
5. Función o mecanismo documentado para expirar holds vencidos.
6. Tests SQL reproducibles o prueba automatizada equivalente.
7. README corto para ejecutar y validar.

## Entidades mínimas requeridas

- `businesses`
- `professionals`
- `services`
- `professional_services`
- `working_hours`
- `calendar_blocks`
- `appointments`

Para esta tarea no hace falta implementar `payment_events`; se incorpora al confirmar pagos en TASK 02/03.

Estados mínimos de `appointments`:

- `hold`
- `confirmed`
- `expired`
- `cancelled`
- `needs_human_review`

## Casos de aceptación

| Prueba | Resultado esperado |
|---|---|
| Consultar Corte clásico | Devuelve slots donde caben 30 + 5 minutos |
| Crear hold disponible | Inserta una cita `hold` con expiración a 10 minutos |
| Segundo hold sobre mismo profesional/horario | Es rechazado sin insertar duplicado |
| Consultar mientras hold está vigente | El horario ya no aparece disponible |
| Expirar hold | Cambia a `expired` o deja de bloquear según diseño explícito |
| Consultar después del vencimiento | El horario vuelve a estar disponible |
| Consultar Coloración | Los slots respetan 90 + 15 minutos |
| Revisar archivos | No contienen tokens, claves ni datos reales |

## Prompt para Claude Code

Trabajá en el repositorio `tdobleta/grip-agency-os` sobre la rama `vertical/barberias-reservas-senia-v1-clean`. Leé primero:

- `products/grip-beauty/PRODUCT_BRIEF.md`
- `products/grip-beauty/TECHNICAL_BLUEPRINT.md`
- `products/grip-beauty/TASK_01_AVAILABILITY_HOLD.md`

Implementá únicamente TASK 01: núcleo Supabase/Postgres de disponibilidad y hold seguro para la barbería demo. Inspeccioná primero la estructura del repo. No conectes APIs reales, no implementes WhatsApp/Mercado Pago/Calendar/Premium y no amplíes el alcance. Dejá pruebas reproducibles y reportá archivos modificados, resultados de pruebas y cualquier decisión pendiente antes de hacer merge a `main`.
