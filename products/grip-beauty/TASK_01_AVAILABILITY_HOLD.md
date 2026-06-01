# TASK 01 — Disponibilidad + Hold Seguro

**Vertical:** Barberías/Peluquerías  
**Plan afectado:** Base, Premium y Full Deluxe (núcleo compartido)  
**Estado:** Lista para ejecutar con Claude Code / n8n  
**No incluye:** WhatsApp real, Mercado Pago real, módulos Premium, web ni llamadas.

## Objetivo único

Construir el primer núcleo ejecutable de GRIP Barberías: dado un negocio ficticio, un servicio, una fecha y un profesional opcional, el sistema devuelve horarios disponibles y permite crear una reserva temporal de 10 minutos sin permitir superposición.

## Lo que debe quedar funcionando

1. Datos ficticios de una barbería con dos profesionales y tres servicios.
2. Duración + buffer real por servicio.
3. Horarios laborales y al menos un bloqueo manual.
4. Consulta de slots libres.
5. Creación de un `hold` por 10 minutos.
6. Rechazo de un segundo intento superpuesto sobre el mismo profesional/horario.
7. Expiración o función preparada para liberar holds vencidos.
8. Evidencia reproducible de pruebas.

## Datos de demo

### Negocio

- Nombre: `Barbería Norte Demo`
- Timezone: `America/Argentina/Mendoza`
- Plan: `base`
- Hold: `10` minutos
- Número humano ficticio: `+5492610000000`

### Profesionales

| Profesional | Horario inicial de prueba | Servicios |
|---|---|---|
| Juan | Lunes a sábado 09:00-13:00 y 15:00-19:00 | Corte clásico, Corte + barba |
| Lucas | Lunes a sábado 10:00-18:00 | Corte clásico, Coloración |

### Servicios

| Servicio | Precio demo ARS | Duración | Buffer | Seña demo ARS |
|---|---:|---:|---:|---:|
| Corte clásico | 18.000 | 30 min | 5 min | 5.000 |
| Corte + barba | 25.000 | 45 min | 5 min | 7.000 |
| Coloración | 45.000 | 90 min | 15 min | 15.000 |

### Bloqueo manual mínimo

- Juan bloqueado un día de prueba de `13:00` a `15:00`.

## Decisiones técnicas obligatorias

- La base de control será Supabase/Postgres; Google Calendar no reemplaza el control de hold.
- La disponibilidad debe calcularse con `duración + buffer`.
- Un hold vigente bloquea el slot exactamente como una reserva confirmada.
- Un hold vencido ya no bloquea disponibilidad.
- Dos solicitudes simultáneas o repetidas no pueden crear dos holds superpuestos para el mismo profesional.
- La solución debe poder llamarse desde n8n luego; priorizar RPCs/endpoint claro sobre lógica repartida en nodos.
- No incluir claves, tokens ni datos reales.

## Entregables esperados del agente

Crear dentro del repo una carpeta técnica coherente, por ejemplo `supabase/` o `implementation/`, si todavía no existe. Antes de elegir estructura, inspeccionar el repo actual y no romper su organización.

Entregables mínimos:

1. Migración SQL o esquema reproducible para las tablas estrictamente necesarias.
2. Seed de datos ficticios del demo.
3. RPC/función o endpoint para consultar disponibilidad.
4. RPC/función o endpoint transaccional para crear hold.
5. Mecanismo para expirar/liberar hold vencido.
6. Script SQL de prueba o test automatizado que demuestre los casos de aceptación.
7. README corto con cómo ejecutar la prueba y qué resultado esperar.

## Tablas mínimas esperadas

Se permite ajustar nombres si el repo ya trae convención, pero la lógica debe cubrir:

- businesses
- professionals
- services
- professional_services
- working_hours
- calendar_blocks
- appointments

`appointments.status` debe contemplar como mínimo:

- `hold`
- `confirmed`
- `expired`
- `cancelled`
- `needs_human_review`

## Condiciones de aceptación

| Test | Resultado esperado |
|---|---|
| Buscar disponibilidad para Corte clásico | Ofrece slots donde cabe 30 + 5 min |
| Crear hold válido | Crea una única cita `hold` con vencimiento a 10 min |
| Intentar mismo slot otra vez | Falla controladamente; no inserta segundo hold |
| Consultar disponibilidad con hold vigente | El slot tomado no aparece |
| Expirar hold | Estado pasa a `expired` o deja de bloquear según implementación documentada |
| Consultar tras vencimiento | El slot vuelve a aparecer |
| Probar servicio largo | Coloración bloquea 90 + 15 min |
| Seguridad básica | No existen secretos o datos reales en archivos/commits |

## Prohibiciones para TASK 01

- No conectar WhatsApp real.
- No conectar Mercado Pago real.
- No construir recordatorios/reseñas/rebooking.
- No crear landing ni dashboard.
- No meter lógica conversacional de Claude todavía.
- No convertir esto en una plataforma general multi-vertical.

## Prompt operativo para Claude Code

Trabajá en el repositorio `tdobleta/grip-agency-os`, rama `vertical/barberias-reservas-senia-v1`. Leé primero `products/grip-beauty/PRODUCT_BRIEF.md`, `products/grip-beauty/TECHNICAL_BLUEPRINT.md` y este archivo. Implementá únicamente TASK 01: disponibilidad + hold seguro de 10 minutos para la barbería demo. Inspeccioná estructura antes de agregar archivos. Usá Supabase/Postgres como núcleo. No conectes APIs reales ni construyas módulos fuera de alcance. Antes de cerrar, ejecutá o entregá pruebas reproducibles de cada condición de aceptación y reportá archivos modificados, decisiones técnicas y riesgos pendientes.
