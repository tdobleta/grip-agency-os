# GRIP — Arquitectura Comercial por Planes Verticales v0.2

**Fecha:** 2026-05-30  
**Estado:** Dirección comercial confirmada por el fundador

## 1. Modelo exacto

GRIP construye automatizaciones modulares por dentro, pero las vende hacia afuera como **planes integrados por rubro**.

El cliente no debe entrar a Instagram y encontrarse con una lista técnica de automatizaciones aisladas para armar. Debe ver soluciones completas, simples y escalonadas según el nivel de operación que quiera automatizar.

```text
GRIP construye módulos internos:
respuesta + reserva + seguimiento + reseñas + CRM + reportes

GRIP vende planes visibles:
Plan Inicial      Plan Premium      Plan Deluxe
```

Cada plan combina automatizaciones con un resultado comercial entendible. Cuando el cliente consulta, se puede ajustar el plan a su operación, pero la vidriera vende paquetes claros.

## 2. Dos estructuras simultáneas

### Estructura interna — biblioteca modular

Se usa para investigar templates, construir, reutilizar, probar y mantener automatizaciones.

```text
Módulos internos
├── Respuesta inteligente
├── Captura y CRM
├── Disponibilidad / agenda
├── Reserva o turno
├── Recordatorio
├── Seguimiento
├── Reseñas
├── Pagos / señas
├── Reportes
└── Reactivación de clientes
```

### Estructura comercial — planes por rubro

Se usa en Instagram, landing, demos y venta.

```text
Destacadas GRIP
├── Hotelería
│   ├── Plan Inicial
│   ├── Plan Premium
│   └── Plan Deluxe
├── Peluquerías
│   ├── Plan Inicial
│   ├── Plan Premium
│   └── Plan Deluxe
└── Gastronomía
    ├── Plan Inicial
    ├── Plan Premium
    └── Plan Deluxe
```

## 3. Regla de diseño de los planes

Cada rubro tendrá tres niveles de oferta:

| Nivel | Qué debe comunicar | Qué evita |
|---|---|---|
| **Inicial** | Resolver el problema principal con una experiencia simple | Parecer caro o excesivo para un negocio chico |
| **Premium** | Capturar más oportunidades y mejorar seguimiento/reputación | Vender solo eficiencia sin impacto visible |
| **Deluxe** | Ordenar operación, datos y crecimiento con sistema completo | Quedarse en un bot aislado sin inteligencia de negocio |

Los nombres finales pueden cambiar luego (`Base`, `Growth`, `Full System`; o nombres más de marca), pero la lógica de tres niveles queda definida.

## 4. Cómo debe verse una destacada por rubro

### Historia 1 — Presentación del problema

Explica el dolor principal del rubro sin hablar todavía de tecnología.

### Historia 2 — Qué hace GRIP en ese rubro

Muestra el recorrido completo posible de automatización, no para elegir piezas sueltas sino para comprender el potencial.

### Historia 3 — Plan Inicial

Muestra el sistema mínimo que ya genera valor.

### Historia 4 — Plan Premium

Muestra cómo se amplía el flujo para seguimiento, experiencia y reputación.

### Historia 5 — Plan Deluxe

Muestra el sistema más completo: CRM, datos, reportes, recuperación y operación integrada.

### Historia final — CTA

> Elegimos el plan según cómo trabaja hoy tu negocio y lo adaptamos a tu operación.

## 5. Ejemplo confirmado de estructura: Hotelería

La hotelería/cabañas/alojamientos es un rubro con muchas oportunidades de automatización porque el recorrido del huésped tiene varias etapas:

```text
Consulta → Disponibilidad/Reserva → Confirmación → Antes de llegar → Estadía → Después de irse → Nueva visita
```

### Plan Inicial — Respuesta & Reserva

**Objetivo:** dejar de perder consultas y convertirlas en solicitudes o reservas ordenadas.

```text
Consulta por WhatsApp
 → agente de respuesta inteligente
 → recopila fechas, huéspedes y tipo de alojamiento
 → informa opciones aprobadas o deriva disponibilidad
 → registra solicitud / crea reserva si la integración lo permite
 → envía confirmación inicial
```

**Incluye:**

- agente de respuesta por WhatsApp para preguntas y solicitud de reserva;
- captura de fechas, cantidad de huéspedes y necesidad principal;
- confirmación automática de recepción/reserva según sistema disponible;
- notificación al alojamiento cuando llega una consulta/reserva relevante;
- historial básico de consultas o reservas gestionadas.

**Nota operativa:** “reserva automática” solo puede prometerse cuando exista integración confiable con agenda, motor de reservas o disponibilidad real del alojamiento. Sin esa integración, se vende como captura inteligente + solicitud/confirmación asistida.

### Plan Premium — Reserva & Experiencia

**Objetivo:** sumar seguimiento y mejorar la experiencia del huésped, aumentando las oportunidades de conversión y de reseñas sin prometer resultados garantizados.

```text
Todo el Plan Inicial
 → seguimiento automático si consultó y no completó reserva
 → recordatorio previo a llegada
 → mensaje con información útil de check-in
 → solicitud de reseña después de la estadía
```

**Incluye:**

- todo el Plan Inicial;
- seguimiento de consultas que no avanzaron, con reglas definidas;
- recordatorio antes de la llegada;
- instrucciones automáticas de check-in, ubicación, horarios o recomendaciones aprobadas;
- solicitud automática de reseña en Google después de la estadía;
- alertas internas sobre consultas pendientes o próximas llegadas.

**Cómo se vende bien:** no decir “más probabilidades de reseñas” como garantía; decir “el sistema solicita reseñas en el momento definido para que no dependa de hacerlo manualmente”.

### Plan Deluxe — Operación & Retención

**Objetivo:** convertir la atención y las reservas en una base operativa para seguimiento, repetición y decisiones del negocio.

```text
Todo el Plan Premium
 → CRM de huéspedes e interesados
 → clasificación de consultas/reservas
 → segmentación y reactivación
 → reportes automáticos
 → recuperación de huéspedes anteriores
 → integraciones avanzadas según sistema del alojamiento
```

**Incluye:**

- todo el Plan Premium;
- CRM de interesados y huéspedes con historial operativo permitido;
- clasificación de consultas: nueva reserva, pendiente, confirmada, huésped pasado, seguimiento;
- mensajes de reactivación para huéspedes anteriores bajo reglas/consentimiento aplicables;
- reporte automático de consultas, reservas, seguimientos y reseñas solicitadas;
- integración adicional con calendario, PMS, formulario web, email u otros sistemas del alojamiento cuando sea técnicamente viable;
- derivación humana y alertas para casos que el agente no debe resolver solo.

## 6. Resumen comercial de Hotelería

| Plan | Resultado visible | Automatizaciones combinadas |
|---|---|---|
| **Inicial** | Responde y ordena consultas/reservas | WhatsApp inteligente + captura + confirmación/notificación |
| **Premium** | Acompaña al huésped y activa reputación | Inicial + seguimiento + pre-llegada/check-in + solicitud de reseña |
| **Deluxe** | Construye operación y retención medible | Premium + CRM + segmentación + reactivación + reportes + integraciones |

## 7. Cómo se comunica sin mentir

GRIP puede decir:

- “Respondé consultas de huéspedes automáticamente por WhatsApp.”
- “Automatizá seguimientos, recordatorios e instrucciones de llegada.”
- “Solicitá reseñas sin depender de acordarte después de cada estadía.”
- “Ordená interesados y huéspedes en un CRM con reportes automáticos.”

GRIP no debe prometer sin prueba ni datos:

- “Aumentamos tus reservas X%.”
- “Garantizamos más reseñas.”
- “Reserva automática” si el alojamiento no tiene disponibilidad integrable y validada.
- “Atiende todo sin intervención humana.”

## 8. Implicación para las demás destacadas

El mismo modelo se replica por rubro, pero cada plan combina módulos según su operación:

### Peluquerías / Barberías

- **Inicial:** respuesta + toma/confirmación de turnos.
- **Premium:** inicial + recordatorios + reseñas + recordatorio para volver.
- **Deluxe:** premium + CRM + señas/pagos, reportes y campañas de reactivación, cuando esté validado.

### Gastronomía

- **Inicial:** consultas + reservas/confirmaciones.
- **Premium:** inicial + recordatorios + reseñas + consultas frecuentes.
- **Deluxe:** premium + base de clientes/eventos + campañas + reportes + integraciones avanzadas.

## 9. Próximo trabajo derivado

1. Crear el documento de oferta detallada para `Hotelería` con textos de historias/destacadas.
2. Auditar templates semilla buscando módulos que soporten cada plan.
3. Definir qué plan de Hotelería puede demostrarse primero sin depender de credenciales productivas.
4. Crear luego planes equivalentes para Peluquerías y Gastronomía.
