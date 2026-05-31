# GRIP — Benchmark Protocol v0.1

## Why this exists

GRIP will not adopt tools because they are popular, promoted by influencers, or commonly mentioned in automation circles. Every infrastructure choice must be evaluated against a real GRIP task.

## Decision template

Every evaluated provider/tool must record:

| Field | Required entry |
|---|---|
| Capability under evaluation | What function GRIP needs |
| Candidate | Tool/provider name and documented capability |
| Real test case | A task relevant to a sellable GRIP product |
| Inputs | Data supplied and whether it is public/sanitized |
| Output quality | Completeness, correctness, evidence and usefulness |
| Repeatability | Can the same result be produced again or scheduled? |
| Security/auth | Permissions, OAuth/secrets, logs and isolation |
| Cost | Trial cost and estimated operating cost |
| Failure modes | What breaks or becomes risky |
| Result | Reject / hold / adopt provisionally / adopt |
| Replacement condition | When a selected tool should be reconsidered |

## Benchmark Track A — Tool Gateway / Authentication Layer

### Capability needed

Allow GRIP agents or internal systems to access many tools/APIs with controlled authentication, limited scopes, customer separation and auditability.

### Initial candidates to inspect, not yet selected

- Pipedream MCP
- Composio
- Arcade
- Any materially better alternative found during research

### Required tests

1. Connect to a safe sandbox/service account.
2. Execute one read-only action.
3. Determine whether write actions can be limited or separated.
4. Inspect OAuth/token handling model.
5. Inspect action logs/audit evidence.
6. Determine per-customer credential isolation.
7. Estimate cost at 1, 10 and 50 client installations.

### Passing condition

A candidate is only acceptable if it supports controlled authorization and does not require exposing secrets to prompts or untrusted research agents.

## Benchmark Track B — Market Intelligence

### Capability needed

Identify which vertical/product opportunity should be developed first using market evidence.

### Initial test case: GRIP Beauty

Research public evidence for automation offers targeting salons/barber shops and find public signals of potential local opportunities in Mendoza.

### Required outputs

- international competitor/offering list;
- value proposition and CTA extracted with source evidence;
- visible pricing or pricing model when available;
- channel and automation flow described;
- local prospect criteria and candidate list based only on lawful public signals;
- cost per useful result;
- ability to monitor changes.

### Initial candidate families

- structured local/search/ads/keyword data APIs;
- cited multi-source research APIs;
- controlled extraction/crawling runtimes;
- additional providers discovered during the process.

## Benchmark Track C — Template Discovery and Audit

### Capability needed

Find useful existing workflows/code, verify reuse rights and determine whether a source is commercially valuable.

### Test sources already registered

- `radlabischia/n8n-hospitality-templates`
- `AmplifyAutomation/n8n-templates`

### Required outputs per workflow

- exact asset path;
- use case;
- integrations required;
- license/commercial constraints;
- security risks;
- modifications needed for Argentina/GRIP;
- fit with a product candidate;
- accept/reject/hold decision.

## Benchmark Track D — Product Runtime

### Capability needed

Execute a reliable customer flow for a sellable product.

### GRIP Beauty reference flow

```text
message received
 -> service chosen
 -> availability determined
 -> slot provisionally held
 -> deposit link issued
 -> trusted payment confirmation received
 -> booking confirmed exactly once
 -> customer confirmation sent
 -> reminder scheduled
 -> follow-up/review scheduled
```

### Candidate categories

- visual workflow import/adaptation platforms;
- code-first job/workflow runtimes;
- database/backend services;
- messaging/payment/calendar APIs.

### Required tests

- happy path;
- payment rejected;
- duplicate payment webhook;
- slot becomes unavailable;
- reminder failure/retry;
- manual cancellation/rebooking;
- credential isolation and logs.

## Benchmark outputs folder convention

Every experiment should be saved under:

```text
experiments/<track>/<yyyy-mm-dd>-<experiment-name>/
├── README.md
├── inputs.md
├── results.md
└── decision.md
```

No secret credentials or private customer data may be saved in experiment files.
