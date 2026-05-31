# GRIP — Decision Log

This file records decisions, corrections, evidence, unresolved risks and conditions that could change them.

## D-001 — Brand name: GRIP

- **Date:** 2026-05-30
- **Status:** Accepted
- **Decision:** The agency name is **GRIP**.
- **Evidence:** Founder-selected name and initial logo asset.
- **Open risk:** Domain, social handle and formal trademark availability have not been validated.
- **Closure condition:** Formal availability checks must be recorded before broad public launch or material advertising spend.

## D-002 — Modular technical foundation

- **Date:** 2026-05-30
- **Status:** Accepted, preserved internally
- **Decision:** GRIP's internal factory must be built from reusable automation modules: respuesta, agenda, CRM, recordatorio, pago, seguimiento, reseñas, reportes and synchronization.
- **Reason:** Internal modularity allows reuse across industries and prevents rebuilding the same logic for every vertical.
- **Important clarification:** Internal modularity does not define how offers are displayed publicly.

## D-003 — Commercial storefront correction: sell plans by vertical, not a module picker

- **Date:** 2026-05-30
- **Status:** Accepted; supersedes the earlier “client chooses individual automations from a line” presentation
- **Decision:** In public channels such as Instagram highlights, landing pages and sales decks, each rubro will be shown through integrated plans of increasing scope, such as **Plan Inicial**, **Plan Premium** and **Plan Deluxe**.
- **Example for Hotelería:** Inicial = WhatsApp intelligent response + booking/request handling; Premium = Inicial + follow-up + pre-arrival information + review request; Deluxe = Premium + CRM + segmentation/reactivation + reporting + advanced integrations.
- **Reason:** Clients understand complete outcomes and tiered offers faster than technical automation modules presented as a menu.
- **Boundary:** Plans can later be adapted during the sales process, but the public storefront should present clear packages rather than force the client to design the system.

## D-004 — Select infrastructure through benchmarks rather than recognition/popularity

- **Date:** 2026-05-30
- **Status:** Accepted
- **Decision:** No platform is the default production core simply because templates exist for it or because it is widely known.
- **Implication:** External workflow templates may be useful source assets, but runtime, research and tool-gateway choices remain open until benchmarked against actual GRIP modules and vertical plan demos.
- **Benchmark categories:** tool gateway/auth, research intelligence, extraction/browser infrastructure, workflow runtime, critical job execution and storage/security.

## D-005 — Public repository contains no secrets or customer-sensitive material

- **Date:** 2026-05-30
- **Status:** Accepted
- **Decision:** This repository may store documentation, public research evidence, automation specifications and sanitized demos only.
- **Forbidden:** API keys, `.env` values, access tokens, OAuth secrets, production URLs with secret tokens, customer personal data or exported live conversation/payment data.
- **Reason:** Repository visibility is currently public and product security must begin before customer delivery.

## D-006 — Prior use of GRIP Beauty becomes vertical plan example, not agency structure

- **Date:** 2026-05-30
- **Status:** Accepted
- **Decision:** `GRIP Beauty` remains a possible visible vertical offering/destacada for peluquerías and barberías, with tiered plans; it is not the sole product or the technical organizing principle of the agency.
- **Replacement direction:** Build modules internally and present plan bundles externally by rubro: Hotelería, Peluquerías, Gastronomía and later validated sectors.

## D-007 — First storefront plan design begins with Hotelería

- **Date:** 2026-05-30
- **Status:** Accepted for design, not yet selected as first implementation or sales launch
- **Decision:** Draft the first full public-facing plan structure for `Hotelería`, because the founder used it to express the offer format and the customer journey allows multiple meaningful levels of automation.
- **Open point:** The first plan to actually implement/demonstrate will still depend on template audit, integration feasibility and security/cost review.
