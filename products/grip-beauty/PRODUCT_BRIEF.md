# GRIP Beauty — Product Brief v0.1

**Status:** First practical demonstrator / validation candidate  
**Vertical:** Peluquerías y barberías  
**Created:** 2026-05-30

## 1. Product statement

**GRIP Beauty** is a booking and retention automation system for peluquerías and barberías that receive client enquiries through messaging and lose time, bookings or revenue through manual coordination and no-shows.

### Working sales promise

> Tus clientes consultan por WhatsApp, eligen turno, pagan una seña y reciben confirmación automáticamente.

This promise is provisional and may only be used commercially once the demonstrated flow can actually support it.

## 2. Problem hypothesis

A typical salon/barber shop may experience:

- interruptions while working to answer WhatsApp messages;
- slow replies that lose potential bookings;
- manual scheduling errors;
- reservations with no deposit and avoidable no-shows;
- no structured customer history;
- no automatic rebooking or review follow-up.

These are hypotheses to validate with public research and customer conversations.

## 3. Intended experience

### Customer-facing flow

```text
1. Customer sends a WhatsApp message.
2. System welcomes them and identifies intent to book.
3. Customer selects a service.
4. System presents available time slots based on service duration.
5. Customer chooses a slot.
6. System issues a deposit payment link.
7. Only after trusted payment confirmation, the appointment is confirmed.
8. Customer receives confirmation and reminder.
9. After attendance, customer may receive a review or rebooking request.
```

### Business-facing value

- fewer manual scheduling messages;
- fewer unconfirmed bookings/no-shows;
- cleaner calendar;
- recoverable customer data;
- a visible follow-up process.

## 4. MVP demonstrator scope — not yet production scope

The first demo should show:

- a fictional barber shop with three services;
- available slots for a test week;
- a WhatsApp-like simulated interaction or sandbox channel;
- a test deposit/payment confirmation path;
- booking registration in a safe test database or table;
- confirmation/reminder states;
- simple owner-facing booking view or report.

The first demo must not use a real customer's messaging or payment credentials.

## 5. Candidate integrations — subject to benchmark

| Capability | Candidate type, not selected yet |
|---|---|
| Conversation channel | WhatsApp Business API or controlled simulation for demo |
| Schedule/availability | Calendar API or database-backed scheduling model |
| Deposit/payment | Mercado Pago sandbox/test integration |
| Data layer | Postgres/Supabase candidate |
| Workflow/runtime | To be benchmarked; source templates may use n8n but production core is undecided |
| AI interpretation | Optional for later; first reliability test should not depend entirely on free-form AI decisions |
| Owner reporting | Basic database view/dashboard/report |

## 6. Required safety and reliability tests

The product cannot be treated as sellable until the relevant version proves:

| Test | Expected outcome |
|---|---|
| Valid booking and valid deposit | One confirmed appointment is created |
| Customer abandons before payment | No confirmed appointment |
| Payment rejected | No confirmed appointment; clear recovery path |
| Duplicate payment webhook | Does not create duplicate appointment or duplicate confirmation |
| Slot conflict before confirmation | Does not incorrectly double-book; controlled recovery flow |
| Reminder task fails | Logged retry/recovery behavior |
| Customer requests cancellation/rebooking | Defined manual or automated path |
| Credential review | No secrets in repository or frontend/prompt content |

## 7. Evidence needed before choosing this as first sales vertical

- local interviews or documented conversations with salon/barber owners;
- public opportunity signals from Mendoza-area candidates;
- competitor offer patterns from advanced markets;
- cost of delivering the system safely;
- willingness-to-pay estimate;
- comparison against GRIP Food and GRIP Stay opportunities.

## 8. Demo assets to create later

- fictional business name and profile;
- conversation storyboard;
- demo screen recording;
- one-page offer explanation;
- Instagram highlight mockup for `Beauty`;
- pricing hypothesis only after cost/demand validation.

## 9. Current next actions

1. Audit salon-related source workflows in the seed repositories.
2. Design first market intelligence experiment for salons/barbers.
3. Benchmark candidate runtime/integration strategy for the booking + deposit flow.
4. Build only after test architecture is selected.
