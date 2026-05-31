# GRIP — Decision Log

This file records decisions, corrections, evidence, unresolved risks and conditions that could change them.

## D-001 — Brand name: GRIP

- **Date:** 2026-05-30
- **Status:** Accepted
- **Decision:** The agency name is **GRIP**.
- **Evidence:** Founder-selected name and initial logo asset.
- **Open risk:** Domain, social handle and formal trademark availability have not been validated.
- **Closure condition:** Formal availability checks must be recorded before broad public launch or material advertising spend.

## D-002 — Correct the business model: modular automations, not vertical products

- **Date:** 2026-05-30
- **Status:** Supersedes the earlier vertical-product framing
- **Correction:** GRIP sells **automatizaciones individuales y combinables**. A customer may buy one automation, several connected automations, or a packaged example based on its operational needs.
- **Examples of sellable units:** agendar turno, enviar recordatorio, guardar datos en CRM, responder consultas, solicitar reseña, registrar pagos, generar reportes, sincronizar sistemas.
- **Implication:** `Beauty`, `Food` or `Stay` are not mandatory product lines or the core architecture. Industries are display categories and contexts where modular automations can be demonstrated.
- **Reason for correction:** The founder clarified that GRIP is intended to sell automation implementations broadly, not become a vertical booking system business.

## D-003 — Use rubros as commercial vitrines only

- **Date:** 2026-05-30
- **Status:** Accepted
- **Decision:** Instagram highlights, demos or landing sections may be organized by industries such as peluquerías, hotelería or gastronomía because that makes examples understandable to buyers.
- **Boundary:** The internal catalog and technical work must be organized primarily by automation capability, not by vertical.
- **Example:** A reminder automation may be shown for a barbería, hotel or dentist without becoming three separate products.

## D-004 — Select infrastructure through benchmarks rather than recognition/popularity

- **Date:** 2026-05-30
- **Status:** Accepted
- **Decision:** No platform is the default production core simply because templates exist for it or because it is widely known.
- **Implication:** External workflow templates may be useful source assets, but runtime, research and tool-gateway choices remain open until benchmarked against actual GRIP automation modules.
- **Benchmark categories:** tool gateway/auth, research intelligence, extraction/browser infrastructure, workflow runtime, critical job execution and storage/security.

## D-005 — Public repository contains no secrets or customer-sensitive material

- **Date:** 2026-05-30
- **Status:** Accepted
- **Decision:** This repository may store documentation, public research evidence, automation specifications and sanitized demos only.
- **Forbidden:** API keys, `.env` values, access tokens, OAuth secrets, production URLs with secret tokens, customer personal data or exported live conversation/payment data.
- **Reason:** Repository visibility is currently public and product security must begin before customer delivery.

## D-006 — Retire GRIP Beauty as the first fixed product framing

- **Date:** 2026-05-30
- **Status:** Accepted
- **Decision:** The prior `GRIP Beauty` brief remains useful only as an example bundle for a sector; it is not the first mandatory product or the organizing principle of the agency.
- **Replacement:** Build an automation catalog, audit modules from external sources and choose the first small demos by clarity and sellability.
- **Candidate first demo modules:** `lead-to-CRM`, `appointment reminder`, `review request`, and `appointment creation`.
