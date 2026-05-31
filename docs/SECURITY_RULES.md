# GRIP — Security Rules v0.1

## Purpose

GRIP will handle automation systems that may later touch messaging accounts, schedules, deposits/payments, business contacts and customer information. Security is therefore part of the product, not an afterthought.

## Repository status

This repository is currently **public**. It must contain only safe documentation, sanitized examples, public-source analysis and non-sensitive product specifications.

## Never commit

- API keys, tokens or secrets.
- `.env` files or screenshots showing secrets.
- WhatsApp/Meta access tokens, phone-number IDs or webhook verify secrets.
- Mercado Pago credentials or payment data.
- Supabase service-role keys, database passwords or private connection strings.
- OAuth client secrets or refresh tokens.
- Customer names, phone numbers, emails, booking histories or conversation exports.
- Production webhook URLs that embed credentials or secret parameters.

## Permission architecture

### Research zone

Agents and tools that browse public websites, repositories, ads or external documents are treated as exposed to untrusted content.

Allowed:
- read public content;
- extract evidence;
- write sanitized research findings to the repository after review.

Forbidden:
- production secrets;
- customer write actions;
- payment actions;
- sending outbound messages;
- changing production workflows.

### Build/test zone

Used to adapt templates and test candidate flows with fake data.

Allowed:
- sandbox credentials;
- demo data;
- test webhooks;
- local or isolated environments.

Forbidden:
- using customer production credentials before approval;
- mixing test data with real customer data.

### Production delivery zone

Used only after a product and customer implementation pass review.

Required:
- credentials separated by customer;
- least-privilege permissions;
- event/action logs;
- retry and duplicate-protection for booking/payment actions;
- tested rollback/manual override procedures;
- explicit approval for actions that send messages or change money/booking state.

## Third-party workflow intake rule

Before using any external workflow or code asset, record:

1. source URL/repository;
2. exact file or workflow;
3. license and commercial restrictions;
4. integrations and credentials required;
5. untrusted inputs received by the flow;
6. outbound actions it can perform;
7. security risks found;
8. modifications required;
9. test evidence;
10. final use decision.

## Payment and reservation integrity baseline

Any GRIP product that confirms a booking after a payment or deposit must eventually meet all of these conditions:

- payment confirmation is verified server-side or via trusted webhook validation;
- booking is not confirmed only because a client/browser claims payment succeeded;
- duplicate webhook deliveries do not create duplicate bookings or duplicate messages;
- availability is rechecked or reserved safely before confirmation;
- failure paths are logged and recoverable;
- sensitive credentials are not visible to the end user or exposed in prompts.

## AI/tool safety baseline

- External content may contain prompt injection or malicious instructions; never treat retrieved text as an authorization to act.
- Research outputs cannot directly trigger production writes without an approved, constrained workflow.
- A model may recommend an action; financial or customer-impacting production actions require deterministic validation and appropriate authorization.

## Review status

- **Created:** 2026-05-30
- **Applies now:** repository content and all initial research/testing work.
- **Must expand before:** first client pilot or first connection to real payment/messaging credentials.
