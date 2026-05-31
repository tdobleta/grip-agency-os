# GRIP — Automation Catalog v0.1

**Purpose:** This is the commercial and technical center of GRIP. Every sellable automation enters here before it is demoed, packaged or offered to a client.

GRIP sells automations as modules. Modules may be installed alone or combined into a larger system for a specific business.

## Status meanings

| Status | Meaning |
|---|---|
| Idea | Useful concept, not sourced or proven |
| Source found | Existing template/pattern found for audit |
| Under audit | License, integration, security and feasibility review ongoing |
| Demo candidate | Worth building as a sanitized demonstration |
| Demo built | Functional demo exists |
| Sellable | Scope, setup, security and delivery procedure defined |
| Installed | Implemented for a client |

## Catalog fields required for every module

| Field | Description |
|---|---|
| ID | Stable identifier for the automation |
| Automation name | Clear action-based name |
| Trigger | What starts it |
| Action/result | What happens automatically |
| Useful for | Applicable businesses/use cases |
| Inputs needed | Client information/configuration required |
| Integrations | Apps/APIs/systems involved |
| Complexity | Low / Medium / High, after audit |
| Source/template | Origin if adapted from external material |
| Security risks | Data/actions/credentials handled |
| Demo status | Current state |
| Commercial form | Individual / compatible bundle / custom |

---

# A. Leads, datos y CRM

## AUT-CRM-001 — Guardar consulta automáticamente en CRM

| Field | Entry |
|---|---|
| Status | Idea / priority demo candidate |
| Trigger | New form submission, WhatsApp inquiry, Instagram inquiry or website chat lead |
| Action/result | Creates or updates a contact/lead record in the selected CRM or database |
| Useful for | Almost any business receiving enquiries |
| Typical integrations | Form/webhook or messaging channel + CRM/database + optional internal notification |
| Sellable alone | Yes |
| Compatible bundles | Instant response, follow-up reminder, lead scoring, sales report |
| Why it matters | Easy to explain, broadly applicable and foundational for later automations |
| Main risks | Duplicate contacts, personal-data handling, incorrect field mapping |

## AUT-CRM-002 — Actualizar etapa de un lead automáticamente

| Field | Entry |
|---|---|
| Status | Idea |
| Trigger | Appointment booked, message replied, payment received, quote accepted or manual status event |
| Action/result | Moves lead/customer to a new pipeline stage and records activity |
| Useful for | Services, sales teams, hospitality, agencies, real estate |
| Sellable alone | Yes, when a client already uses CRM |
| Main risks | Incorrect status transitions, overwriting manual work |

## AUT-CRM-003 — Notificar nuevo lead al negocio

| Field | Entry |
|---|---|
| Status | Idea / priority demo candidate |
| Trigger | New qualified enquiry or form submission |
| Action/result | Sends structured notification to owner/team via email, WhatsApp/Telegram/Slack or chosen channel |
| Useful for | Any business that loses speed responding |
| Sellable alone | Yes |
| Main risks | Spam/noise, exposing private lead information in insecure channels |

---

# B. Agenda, turnos y reservas

## AUT-BOOK-001 — Crear turno o reserva automáticamente

| Field | Entry |
|---|---|
| Status | Idea / source candidates exist |
| Trigger | Customer chooses date/time after enquiry or form submission |
| Action/result | Creates appointment/reservation in agenda or booking database and confirms it |
| Useful for | Peluquerías, barberías, estética, hoteles, gastronomía, talleres, profesionales |
| Typical integrations | Messaging/form + calendar/booking system + optional database |
| Sellable alone | Yes |
| Main risks | Double bookings, timezone/hours errors, confirmation before real availability |

## AUT-BOOK-002 — Consultar disponibilidad automáticamente

| Field | Entry |
|---|---|
| Status | Idea |
| Trigger | Customer requests date/service/booking |
| Action/result | Returns available slots based on calendar, service duration and business rules |
| Useful for | Appointment-based businesses |
| Sellable alone | Usually as part of booking flow; may be a standalone improvement |
| Main risks | Incorrect availability, concurrency and blocked slots |

## AUT-BOOK-003 — Reprogramar o cancelar turno automáticamente

| Field | Entry |
|---|---|
| Status | Idea |
| Trigger | Customer requests cancellation/rebooking or confirms option from reminder |
| Action/result | Updates appointment and alerts business/customer |
| Useful for | Appointment businesses |
| Sellable alone | As upgrade to an existing agenda flow |
| Main risks | Unauthorized changes, lost bookings, refund/deposit rules |

---

# C. Recordatorios y notificaciones

## AUT-REM-001 — Enviar recordatorio de turno/reserva

| Field | Entry |
|---|---|
| Status | Source candidates exist / priority demo candidate |
| Trigger | Configured time before scheduled booking, e.g. 24h or 2h before |
| Action/result | Sends reminder with confirmation/cancellation option if applicable |
| Useful for | Salons, hospitality, restaurants, clinics, service appointments |
| Typical integrations | Calendar/database + messaging/email/SMS |
| Sellable alone | Yes; strong simple first offer |
| Main risks | Wrong recipient, timezone errors, excessive messaging, sensitive appointment content |

## AUT-REM-002 — Avisar internamente una nueva reserva, pago o incidencia

| Field | Entry |
|---|---|
| Status | Idea |
| Trigger | Booking/payments/error event |
| Action/result | Internal structured alert to owner or staff |
| Useful for | Any operational business |
| Sellable alone | Yes, especially as operational convenience |
| Main risks | Notification overload, leaking payment/customer details |

---

# D. Atención y respuesta automática

## AUT-MSG-001 — Respuesta automática inicial a una consulta

| Field | Entry |
|---|---|
| Status | Idea / source candidates exist |
| Trigger | Incoming message or website inquiry |
| Action/result | Sends welcome message and routes customer to common next actions |
| Useful for | Any business receiving enquiries |
| Sellable alone | Yes |
| Main risks | Misleading response, messaging platform policies, poor handoff to human |

## AUT-MSG-002 — Responder preguntas frecuentes

| Field | Entry |
|---|---|
| Status | Source candidate exists |
| Trigger | Customer asks known question |
| Action/result | Answers from approved information or routes to human |
| Useful for | Hotels, restaurants, salons, ecommerce, services |
| Sellable alone | Yes |
| Main risks | Incorrect information, hallucinated answers, outdated pricing/hours |

## AUT-MSG-003 — Clasificar consulta y derivarla

| Field | Entry |
|---|---|
| Status | Idea |
| Trigger | Incoming inquiry |
| Action/result | Labels request type/urgency and routes to the correct person or next automation |
| Useful for | Businesses with different services or high message volume |
| Sellable alone | Yes or bundle component |
| Main risks | Misclassification and missed urgent cases |

---

# E. Pagos, estados y comprobación

## AUT-PAY-001 — Enviar link de pago o seña tras una solicitud

| Field | Entry |
|---|---|
| Status | Idea |
| Trigger | Customer chooses service/booking/payment option |
| Action/result | Generates or sends payment/deposit instruction/link |
| Useful for | Reservations and service businesses |
| Sellable alone | Usually paired with booking or order flow |
| Main risks | Fraud/phishing perception, incorrect amount, unverified payment state |

## AUT-PAY-002 — Registrar pago confirmado y notificar

| Field | Entry |
|---|---|
| Status | Idea |
| Trigger | Trusted payment provider notification/webhook |
| Action/result | Updates record and sends defined notification/next step |
| Useful for | Any business receiving digital payment tied to an operation |
| Sellable alone | Yes when business already has payment links/orders |
| Main risks | Duplicate webhooks, fake confirmations, financial integrity |

---

# F. Reputación, retención y seguimiento

## AUT-RET-001 — Solicitar reseña después del servicio

| Field | Entry |
|---|---|
| Status | Source candidates exist / priority demo candidate |
| Trigger | Completed appointment/visit or configured delay after it |
| Action/result | Sends polite review request with review destination link |
| Useful for | Hospitality, salons, restaurants, local services |
| Sellable alone | Yes; very easy to understand |
| Main risks | Asking at wrong time, messaging policy/reputation issues |

## AUT-RET-002 — Recordar volver a reservar

| Field | Entry |
|---|---|
| Status | Source candidates exist |
| Trigger | Time since last service or typical recurrence interval |
| Action/result | Sends rebooking invitation or prompts staff to follow up |
| Useful for | Haircuts, beauty, maintenance, recurring services |
| Sellable alone | Yes |
| Main risks | Customer consent, spam frequency, incorrect last-service date |

## AUT-RET-003 — Recuperar clientes inactivos

| Field | Entry |
|---|---|
| Status | Source candidates exist |
| Trigger | No visit/contact for configured time period |
| Action/result | Creates campaign/action for inactive clients |
| Useful for | Local recurring businesses and hospitality |
| Sellable alone | Yes, with existing data source |
| Main risks | Consent, poor segmentation, message fatigue |

---

# G. Reportes y operación interna

## AUT-OPS-001 — Enviar reporte automático semanal

| Field | Entry |
|---|---|
| Status | Source candidates exist |
| Trigger | Weekly schedule |
| Action/result | Compiles metrics/data and sends a summary to the business owner |
| Useful for | Any business with structured operational data |
| Sellable alone | Yes, if data already exists |
| Main risks | Inaccurate totals, exposing private information, poor data quality |

## AUT-OPS-002 — Sincronizar datos entre herramientas

| Field | Entry |
|---|---|
| Status | Idea |
| Trigger | New/update event or schedule |
| Action/result | Copies/normalizes records across CRM, calendar, spreadsheet or database |
| Useful for | Any business using disconnected tools |
| Sellable alone | Yes |
| Main risks | Duplicate/conflicting data and destructive overwrite |

---

# First demo candidates to decide after source audit

These are the simplest, most transferable automation demonstrations currently worth investigating first:

| Candidate | Why it is strong | Dependency level |
|---|---|---:|
| `AUT-CRM-001` Lead/consulta → CRM | Applicable to almost every business and easy to demo | Low/Medium |
| `AUT-REM-001` Reserva/turno → recordatorio | Clear value and common source templates | Medium |
| `AUT-RET-001` Servicio completado → reseña | Visually simple and useful for local businesses | Low/Medium |
| `AUT-BOOK-001` Mensaje/formulario → turno creado | Strong impact but availability/conflict logic needs care | Medium/High |

## Next catalog action

Audit actual template assets from registered sources and map each useful workflow to one or more module IDs in this catalog.