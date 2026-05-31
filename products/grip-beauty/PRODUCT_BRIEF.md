# GRIP — Ejemplo por Rubro: Peluquerías y Barberías v0.2

**Status:** Ejemplo comercial / no es producto central  
**Rubro mostrado:** Peluquerías y barberías  
**Created:** 2026-05-30  
**Corrected:** 2026-05-30

## 1. Aclaración de estructura

Este archivo no define una línea de producto obligatoria llamada `GRIP Beauty`.

GRIP vende **automatizaciones modulares**. Este documento solo muestra cómo algunos módulos del catálogo podrían combinarse para una peluquería o barbería.

Una peluquería podría contratar:

- solamente recordatorios;
- solamente registro de clientes en CRM;
- solamente pedido automático de reseña;
- agenda automática;
- o un conjunto de varias automatizaciones conectadas.

## 2. Módulos aplicables al ejemplo

| Module ID | Automatización | Se vende sola | Puede combinarse |
|---|---|---:|---:|
| `AUT-MSG-001` | Respuesta automática inicial | Sí | Sí |
| `AUT-CRM-001` | Guardar consulta/cliente en CRM | Sí | Sí |
| `AUT-BOOK-001` | Crear turno automáticamente | Sí | Sí |
| `AUT-BOOK-002` | Consultar disponibilidad | En general como complemento | Sí |
| `AUT-REM-001` | Recordatorio de turno | Sí | Sí |
| `AUT-PAY-001/002` | Seña/pago y confirmación | Según necesidad | Sí |
| `AUT-RET-001` | Pedido de reseña | Sí | Sí |
| `AUT-RET-002` | Recordatorio para volver a reservar | Sí | Sí |

## 3. Ejemplos de ofertas vendibles

### Oferta simple A — Recordatorios automáticos

> Antes de cada turno, tus clientes reciben un recordatorio automático para reducir olvidos y ayudarte a ordenar la agenda.

Módulo central: `AUT-REM-001`.

### Oferta simple B — Clientes ordenados en CRM

> Cada persona que consulta por un turno queda registrada automáticamente para que no pierdas contactos ni seguimiento.

Módulo central: `AUT-CRM-001`.

### Oferta simple C — Reseñas posteriores

> Después de una atención, enviás automáticamente un mensaje para pedir reseña o volver a reservar.

Módulos centrales: `AUT-RET-001` o `AUT-RET-002`.

### Ejemplo de paquete compuesto — Reserva completa

```text
Consulta entrante
 -> registro del cliente
 -> turno/agendado
 -> recordatorio
 -> reseña o rebooking
```

La seña/pago solo se incorpora si ese negocio lo necesita y si la implementación financiera está validada correctamente.

## 4. Demo recomendada para este rubro

Una demo visual de peluquería puede mostrar módulos separados mediante escenas simples:

1. Cliente consulta por WhatsApp.
2. Se registra el contacto en una base/CRM.
3. Se agenda un turno o se confirma una reserva de prueba.
4. Se dispara un recordatorio.
5. Se envía un pedido de reseña después del servicio.

No es necesario construir todo el paquete para poder vender primero un módulo simple.

## 5. Seguridad y prueba

Cada módulo debe probarse según lo que hace:

| Módulo | Riesgo principal | Prueba mínima |
|---|---|---|
| CRM | datos duplicados o mal guardados | un lead nuevo se registra una sola vez y con campos correctos |
| Turno | doble reserva o agenda incorrecta | turno creado correctamente; conflicto controlado si aplica |
| Recordatorio | mensaje equivocado o fuera de horario | se envía a contacto de prueba en momento configurado |
| Pago/seña | confirmación falsa o duplicada | solo evento confiable cambia estado y no se duplica |
| Reseña/rebooking | spam o momento incorrecto | reglas claras de cuándo y a quién se envía |

## 6. Uso comercial correcto

Los contenidos por rubro de GRIP deberán decir:

> “Estas son automatizaciones que podemos instalar en una peluquería.”

No deberán comunicar que GRIP es únicamente una plataforma para peluquerías ni que todos los módulos deben contratarse juntos.
