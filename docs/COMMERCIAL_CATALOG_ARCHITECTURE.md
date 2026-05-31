# GRIP — Arquitectura del Catálogo Comercial v0.1

**Fecha:** 2026-05-30  
**Estado:** Dirección comercial confirmada por el fundador

## 1. Modelo exacto

GRIP vende automatizaciones individuales y combinables.

La experiencia pública se organiza por **rubro** porque el cliente entiende más rápido una solución cuando la ve aplicada a su propio negocio. Dentro de cada destacada, landing o presentación por rubro, GRIP muestra una **línea de automatizaciones posibles**, donde cada módulo puede elegirse solo o en combinación con otros.

```text
Destacada: HOTELERÍA

Consulta automática ─── Registro en CRM ─── Seguimiento ─── Reserva ─── Recordatorio ─── Check-in ─── Reseña ─── Reporte
      ○                    ○                  ○              ○             ○              ○             ○            ○

El cliente elige:       [CRM] + [Seguimiento] + [Recordatorio]
```

La línea punteada representa el recorrido posible del negocio, no una obligación de contratar un sistema completo.

## 2. Dos estructuras simultáneas

### Estructura interna — por tipo de automatización

Se usa para construir, auditar, mantener y reutilizar módulos.

```text
Catálogo interno
├── CRM y datos
├── Agenda y reservas
├── Recordatorios y notificaciones
├── Atención automática
├── Pagos y estados
├── Retención y reputación
└── Reportes y operación
```

### Estructura pública — por rubro

Se usa para vender y para mostrar al cliente qué puede automatizar en su realidad.

```text
Destacadas / Landing
├── Hotelería
├── Peluquerías
├── Gastronomía
├── Inmobiliarias
├── Clínicas/estética, solo cuando corresponda por datos y cumplimiento
└── Otros rubros validados
```

## 3. Cómo debe verse una destacada

Cada destacada por rubro debe seguir un formato claro:

### Historia 1 — Dolor del rubro

Ejemplo hotelería:

> Consultas que llegan tarde, huéspedes sin seguimiento y tareas repetitivas que todavía se hacen a mano.

### Historia 2 — Línea de automatizaciones posibles

Visual central: línea punteada o circuito con módulos individuales.

```text
Consulta
  · · · CRM
  · · · Disponibilidad
  · · · Reserva
  · · · Recordatorio
  · · · Check-in
  · · · Reseña
  · · · Reporte
```

### Historias 3 en adelante — Cada automatización individual

Una historia por módulo, explicando una sola acción:

- qué dispara la automatización;
- qué hace sola;
- qué problema evita;
- con qué otras puede combinarse.

### Historia final — Selección personalizada

> Elegí las automatizaciones que tu negocio necesita. GRIP las conecta y las deja funcionando.

CTA provisional:

> Contanos qué tarea repetitiva querés automatizar.

## 4. Ejemplo: Hotelería

### Línea de módulos posibles

| Orden visual | Automatización que se muestra | Puede venderse sola | Combina bien con |
|---:|---|---:|---|
| 1 | Responder consulta inicial automáticamente | Sí | CRM, disponibilidad, seguimiento |
| 2 | Guardar huésped interesado en CRM | Sí | seguimiento, reserva, reportes |
| 3 | Enviar seguimiento si no reservó | Sí | CRM, consulta inicial |
| 4 | Registrar o confirmar reserva | Sí | recordatorio, pagos, check-in |
| 5 | Enviar recordatorio antes de llegada | Sí | reserva, check-in |
| 6 | Enviar instrucciones de check-in | Sí | reserva confirmada |
| 7 | Pedir reseña luego de la estadía | Sí | checkout/registro de estadía |
| 8 | Generar reporte automático | Sí | CRM/reservas/datos existentes |

### Ejemplos de combinaciones elegidas por el cliente

**Hotel pequeño que solo necesita orden:**

```text
Consulta → CRM → Notificación al dueño
```

**Cabañas que pierden seguimientos:**

```text
Consulta → CRM → Seguimiento automático → Recordatorio
```

**Alojamiento con proceso más completo:**

```text
Consulta → Reserva → Recordatorio → Check-in → Reseña → Reporte
```

## 5. Ejemplo: Peluquerías / Barberías

```text
Consulta ─── CRM ─── Turno ─── Recordatorio ─── Seña opcional ─── Reseña ─── Volver a reservar
```

Módulos vendibles individuales:

- guardar clientes que consultan;
- agendar turnos;
- recordar citas;
- cobrar seña, solo si se implementa y valida correctamente;
- pedir reseñas;
- recordar nuevo corte después de X días.

## 6. Ejemplo: Gastronomía

```text
Consulta ─── Reserva ─── Confirmación ─── Recordatorio ─── Reseña ─── Base de clientes ─── Reporte
```

Módulos vendibles individuales:

- responder consultas de reserva;
- registrar una reserva;
- confirmar asistencia;
- pedir reseña luego de visita;
- guardar clientes frecuentes;
- enviar reportes de reservas o consultas.

## 7. Regla comercial principal

GRIP no debe decir:

> “Comprá nuestro sistema completo para hoteles.”

GRIP debe decir:

> “Estas son las tareas que podemos automatizar en tu hotel. Elegís las que necesitás y las conectamos para que funcionen juntas.”

## 8. Implicación para el catálogo y la tecnología

Cada automatización deberá tener dos etiquetas:

1. **Familia funcional interna**: CRM, reservas, recordatorios, pagos, etc.
2. **Aplicaciones por rubro**: hotelería, peluquerías, gastronomía, servicios, etc.

Así, un mismo módulo puede mostrarse en varias destacadas sin duplicar el trabajo técnico.

## 9. Próximo trabajo derivado

1. Auditar templates existentes y mapear cada workflow a módulos individuales.
2. Diseñar el primer mapa visual de automatizaciones para la destacada `Hotelería`.
3. Crear luego los mapas equivalentes para `Peluquerías` y `Gastronomía`.
4. Elegir las primeras automatizaciones que puedan demostrarse de forma simple y segura.
