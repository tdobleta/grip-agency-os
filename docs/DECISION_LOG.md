# GRIP — Decision Log

This file records decisions, the evidence behind them, unresolved risks and conditions that could change them.

## D-001 — Create GRIP as one master brand with vertical solutions

- **Date:** 2026-05-30
- **Status:** Accepted
- **Decision:** The agency name is **GRIP**. Vertical offerings will live under one brand rather than separate brands per industry.
- **Working architecture:** GRIP Beauty, GRIP Food, GRIP Stay, later validated verticals.
- **Reason:** Allows a focused public identity while reusing technical modules across industries.
- **Evidence:** Founder-selected name and initial logo asset; initial seed templates cover salons, restaurants and hospitality.
- **Open risk:** Domain, social handle and formal trademark availability have not been validated.
- **Closure condition:** Formal availability checks must be recorded before broad public launch or material advertising spend.

## D-002 — Use GRIP Beauty as the first practical demonstrator, not yet as final market selection

- **Date:** 2026-05-30
- **Status:** Accepted with validation pending
- **Decision:** Begin practical product design around turnos por WhatsApp con seña for peluquerías/barberías.
- **Reason:** Simple to explain, visual to demonstrate, directly addresses no-shows/manual attention, and matches the founder's immediate selling interest.
- **Not yet proven:** That this vertical has the highest market opportunity compared with hospitality or gastronomy.
- **Validation required:** Gate 1 intelligence benchmark and Gate 2 vertical comparison.

## D-003 — Select infrastructure through benchmarks rather than recognition/popularity

- **Date:** 2026-05-30
- **Status:** Accepted
- **Decision:** No platform is the default production core simply because templates exist for it or because it is widely known.
- **Implication:** n8n templates may be useful source assets, but runtime, research and tool-gateway choices remain open until benchmarked against GRIP cases.
- **Benchmark categories:** tool gateway/auth, research intelligence, local opportunity data, extraction/browser infrastructure, workflow runtime, critical job execution and storage/security.

## D-004 — Public repository contains no secrets or customer-sensitive material

- **Date:** 2026-05-30
- **Status:** Accepted
- **Decision:** This repository may store documentation, public research evidence, product specifications and sanitized demos only.
- **Forbidden:** API keys, `.env` values, access tokens, OAuth secrets, production URLs with secret tokens, customer personal data or exported live conversation/payment data.
- **Reason:** Repository visibility is currently public and product security must begin before customer delivery.
