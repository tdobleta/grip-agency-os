# GRIP — Peluquerías / Barberías: Turnos con Seña y Agenda Visual

**Estado:** Especificación funcional inicial para construir y ofrecer  
**Fecha:** 2026-05-31  
**Tipo:** Plantilla completa por rubro

## 1. Resultado que compra la peluquería

GRIP instala un sistema donde:

1. el cliente escribe por WhatsApp;
2. un agente personalizado entiende qué quiere reservar;
3. muestra servicios y horarios disponibles;
4. toma nombre y teléfono;
5. bloquea el horario elegido durante 10 minutos;
6. envía un link de seña;
7. confirma el turno solamente cuando el pago fue verificado;
8. libera el horario si el cliente no paga a tiempo;
9. el barbero ve todo en una agenda clara desde el celular;
10. el sistema puede sumar recordatorios, reseñas, rebooking, CRM y reportes.

## 2. La experiencia tiene dos caras

### Cliente — WhatsApp

```text
Hola
 → elegir o describir servicio
 → recibir horarios disponibles
 → elegir turno
 → informar nombre/teléfono
 → pagar seña dentro de 10 minutos
 → recibir confirmación
 → recibir recordatorio
```

### Barbero / peluquería — Panel de agenda

```text
Hoy — Martes 02/06

09:00  Disponible
09:30  Confirmado  | Juan Pérez | Corte + barba | Seña pagada
10:15  En espera    | Sofía      | Color         | vence en 06:42
12:00  Bloqueado    | Almuerzo
15:00  Disponible
```

El barbero no debe depender de revisar conversaciones ni abrir una hoja de cálculo. Debe poder mirar el celular y entender inmediatamente:

- quién viene;
- a qué hora;
- qué servicio se hará;
- cuánto dura;
- si la seña está pagada;
- qué turnos están pendientes de pago;
- qué horarios siguen libres;
- qué turnos fueron cancelados o reprogramados.

## 3. Panel del profesional — requisito obligatorio

### Vista principal: Agenda del día

Debe ser la primera pantalla y mostrar bloques de horario con estados visuales:

| Estado | Significado | Acción disponible |
|---|---|---|
| Disponible | Puede ofrecerse a clientes | Bloquear manualmente / crear turno |
| Reservado temporalmente | Un cliente está pagando; no mostrar a otro | Ver vencimiento / liberar si corresponde |
| Confirmado | Seña verificada y turno real | Ver datos / cancelar / reprogramar / marcar completado |
| Bloqueado | Horario no atendible | Desbloquear |
| Cancelado | Turno dado de baja | Ver historial |
| Completado | Servicio realizado | Activar reseña/rebooking según plan |

### Datos visibles en cada turno confirmado

- hora de inicio y duración;
- nombre del cliente;
- teléfono/contacto;
- servicio;
- profesional asignado, si hay más de uno;
- estado de seña/pago;
- notas mínimas autorizadas;
- acceso rápido para contactar al cliente;
- acciones: reprogramar, cancelar, marcar completado.

### Vistas necesarias

| Vista | Para qué sirve |
|---|---|
| Hoy | Uso diario rápido del barbero |
| Semana | Ver disponibilidad general y organizar agenda |
| Pendientes de pago | Ver holds todavía vigentes y tiempo restante |
| Clientes, solo Deluxe | Historial y recurrencia permitida |
| Configuración | Servicios, duración, horarios, señas, feriados, profesionales |
| Reportes, solo Deluxe | Turnos, pagos/señas, cancelaciones, clientes recurrentes |

### Diseño de uso

- Mobile-first: el barbero lo usa desde el teléfono.
- Muy pocos botones y lectura rápida.
- Botón grande: **Nuevo turno manual** para clientes que llaman o llegan en persona.
- Cambios manuales del barbero deben actualizar disponibilidad que ve WhatsApp.
- Un turno confirmado automáticamente debe aparecer en el panel en tiempo real o casi inmediato.

## 4. Corrección técnica: no usar Google Sheets como agenda principal

Google Sheets puede ofrecerse como exportación o reporte opcional. No debe ser el motor de horarios, reservas temporales ni confirmaciones de pago.

### Fuente de verdad recomendada

| Capa | Función |
|---|---|
| WhatsApp Business Platform | Conversación con cliente |
| Claude API | Interpretar mensajes libres y responder FAQ aprobadas |
| Runtime/workflow a evaluar | Orquestar mensajes, pagos, jobs y notificaciones |
| Supabase/PostgreSQL | Servicios, agenda, holds, turnos, pagos y estados |
| Mercado Pago | Seña y verificación de pago |
| Panel web/PWA | Agenda cómoda del barbero desde celular/PC |
| Sheets opcional | Export o reporte, no operación crítica |

## 5. Oferta comercial por planes

## Plan Inicial — Agenda con Turnos Confirmados

**Objetivo:** recibir turnos por WhatsApp con seña y verlos ordenados en una agenda simple.

Incluye:

- agente personalizado en WhatsApp;
- servicios, duraciones y precios/señas configurables;
- horarios disponibles reales;
- captura de nombre y teléfono;
- bloqueo temporal de 10 minutos;
- link de seña Mercado Pago;
- confirmación automática tras pago verificado;
- liberación automática si vence el tiempo;
- aviso al peluquero;
- panel de agenda diaria/semanal con turnos y estados;
- creación/bloqueo manual de horarios desde el panel.

## Plan Premium — Agenda + Seguimiento

Todo el Plan Inicial, más:

- recordatorios automáticos antes del turno;
- cancelación/reprogramación asistida;
- solicitud de reseña después del servicio completado;
- recordatorio para volver a reservar según tipo de servicio o período;
- alertas de agenda/próximos turnos.

## Plan Deluxe — Clientes y Operación

Todo el Premium, más:

- CRM de clientes y consultas;
- historial de visitas/servicios;
- clasificación operativa: nuevo, frecuente, inactivo, no-show;
- campañas de reactivación bajo reglas aplicables;
- reportes de turnos, señas, cancelaciones, reseñas solicitadas y recurrencia;
- múltiples profesionales/agendas si el negocio lo necesita.

## 6. Flujo del cliente — camino feliz

```text
Cliente: Hola, quiero sacar turno
Bot: Hola, soy el asistente de [Peluquería]. ¿Qué servicio querés reservar?
     [Corte] [Color] [Brushing] [Corte + Barba] [Otro / asesoramiento]

Cliente: quiero teñirme mañana a la tarde
Claude interpreta: servicio=color, fecha=mañana, franja=tarde
Sistema valida el servicio y consulta slots reales
Bot: Para color, mañana tenemos estos horarios disponibles:
     [15:00] [16:30] [18:00]

Cliente: 16:30
Bot: Para reservarlo, pasame tu nombre y número de teléfono.

Cliente: Sofía Gómez, 261...
Sistema intenta crear hold exclusivo por 10 minutos
Bot: Te reservamos temporalmente el horario por 10 minutos. Confirmalo pagando la seña acá: [link]

Mercado Pago confirma pago verificado
Sistema convierte hold en booking confirmado
Bot cliente: Turno confirmado ✓ Te esperamos el [fecha] a las [hora] para [servicio].
Panel barbero: aparece el turno como Confirmado — Sofía Gómez — Color — Seña pagada.
```

## 7. Bot inteligente con respuestas predeterminadas + Claude

### Regla de seguridad y calidad

Claude no puede reservar, liberar horarios ni confirmar pagos. Claude solo interpreta texto libre o redacta una respuesta dentro de información autorizada. Las acciones reales las ejecuta el sistema mediante reglas y base de datos.

### Cuándo usar respuestas predeterminadas

- bienvenida;
- botones/listas de servicios;
- horarios disponibles;
- solicitud de datos;
- envío del link de pago;
- confirmación de turno;
- vencimiento de reserva temporal;
- recordatorio;
- cancelación o reprogramación.

### Cuándo usar Claude

- el cliente escribe libremente: “quiero cortarme mañana después de las 5”;
- pregunta algo expresado de manera distinta a las FAQs;
- no responde con un botón/lista;
- expresa duda o pide asesoramiento;
- el mensaje debe clasificarse para derivación humana.

### Ejemplo de salida estructurada de Claude

```json
{
  "intent": "choose_service",
  "service_id": "color_completo",
  "requested_date": "2026-06-01",
  "requested_time_range": "afternoon",
  "customer_name": null,
  "phone": null,
  "needs_human": false,
  "confidence": 0.94
}
```

### Si responde cualquier cosa o no se entiende

Si la salida es ambigua, inválida o con baja confianza:

```text
No llegué a interpretar tu respuesta. Para ayudarte con el turno, elegí una opción:
[Ver servicios] [Hablar con la peluquería]
```

## 8. Estados de conversación

| Estado | Significado | Acción válida siguiente |
|---|---|---|
| `new` | Primera consulta | Bienvenida + servicio |
| `awaiting_service` | Falta servicio | Interpretar/seleccionar servicio |
| `awaiting_slot` | Falta horario | Elegir slot disponible |
| `awaiting_customer_data` | Falta nombre/teléfono | Validar datos y crear hold |
| `awaiting_payment` | Slot retenido 10 min | Esperar pago / informar tiempo restante |
| `confirmed` | Pago verificado y turno confirmado | Recordar / reprogramar / cancelar según plan |
| `expired` | Se venció el hold | Elegir nuevo horario |
| `human_handoff` | Requiere persona | Avisar al local |
| `cancelled` | Cancelado | Reiniciar si solicita |

## 9. Regla de reserva temporal de 10 minutos

Cuando el cliente elige horario y entrega datos:

1. La base intenta pasar el slot de `available` a `held` en una operación segura.
2. Solo gana un cliente; si otro ya tomó el horario, se informa que dejó de estar disponible.
3. Se crea un `booking_hold` con vencimiento de 10 minutos.
4. Se genera un pago asociado al hold.
5. Se envía el link y se informa claramente el vencimiento.

Si pasan 10 minutos sin pago confirmado:

- se marca el hold como vencido;
- el horario vuelve a `available`;
- el panel del barbero actualiza el estado;
- se informa al cliente una sola vez y se ofrece elegir otro horario.

Si llega un pago tarde y el horario ya fue ocupado, el sistema no debe confirmar solo: alerta al negocio para resolver reasignación o devolución.

## 10. Workflows completos

### WF1 — Conversación y toma de turno

```text
WhatsApp Trigger/Webhook
 → Normalizar mensaje (texto, botón, lista)
 → Identificar negocio y cliente
 → Leer estado en base de datos
 → Si texto libre: Claude interpreta en formato estructurado
 → Validar acción según estado
 → Consultar servicios/slots o pedir datos
 → Crear hold + pago cuando corresponde
 → Enviar mensaje aprobado
 → Registrar evento
```

### WF2 — Confirmación de pago

```text
Webhook Mercado Pago
 → Consultar pago real en API MP
 → Comparar pago, monto y referencia del hold
 → Confirmación idempotente en base:
      hold + slot → booking confirmado
 → Actualizar panel
 → WhatsApp al cliente
 → Notificación al barbero
 → Auditoría
```

### WF3 — Liberación de reservas vencidas

```text
Schedule cada 1–3 minutos
 → Buscar holds activos vencidos sin pago confirmado
 → Liberar slots
 → Marcar holds expired
 → Actualizar conversación y panel
 → Avisar al cliente una sola vez
 → Auditoría
```

### WF4 — Recordatorios y reprogramación (Premium)

```text
Turnos confirmados próximos
 → Enviar recordatorio
 → Registrar envío
 → Permitir solicitud de cambio/cancelación según reglas
```

### WF5 — Reseña y rebooking (Premium)

```text
Barbero marca turno completado en panel
 → Enviar pedido de reseña después del plazo definido
 → Programar recordatorio de nueva reserva si aplica
```

### WF6 — CRM y reportes (Deluxe)

```text
Consultas + turnos + visitas
 → Actualizar perfil/historial del cliente
 → Clasificar clientes operativamente
 → Generar reportes
 → Activar reactivación bajo reglas aplicables
```

## 11. Datos principales del sistema

| Entidad | Qué guarda |
|---|---|
| `businesses` | Datos/configuración de la peluquería |
| `professionals` | Barberos/peluqueros y agenda asignada |
| `services` | Servicio, duración, seña, estado |
| `slots` | Horarios y estado real de disponibilidad |
| `booking_holds` | Reservas temporales y vencimiento |
| `bookings` | Turnos confirmados/cancelados/completados |
| `customers` | Datos mínimos del cliente y permisos aplicables |
| `conversations` | Estado de WhatsApp y selección actual |
| `payments` | Estado verificado de seña |
| `events_audit` | Eventos operativos importantes sin secretos |

## 12. Configuración que pide GRIP al cliente

- nombre del local y logo opcional;
- servicios, duración y seña;
- profesionales y horarios;
- excepciones, días cerrados y feriados;
- tono del bot y FAQs aprobadas;
- número/canal WhatsApp autorizado;
- cuenta Mercado Pago;
- política de cancelación/reprogramación;
- anticipación de recordatorios;
- link de Google Reviews;
- quién recibe notificaciones internas;
- qué datos desea ver en panel y reportes.

## 13. Condición para venderlo como plantilla lista

Antes de ofrecerlo como sistema instalable, debe existir una demo funcional que demuestre:

- conversación libre + botones/listas;
- slot disponible que se retiene por 10 minutos;
- pago sandbox confirmado y booking único;
- liberación por vencimiento;
- panel mobile del barbero actualizado;
- al menos un recordatorio de prueba;
- control de duplicados y fallas básicas;
- ninguna credencial expuesta.
