# GRIP — External Sources Register v0.1

This register records external templates, repositories and assets investigated by GRIP. Registration does **not** authorize commercial use or product deployment.

## Status meanings

| Status | Meaning |
|---|---|
| Registered | Source identified and high-level relevance recorded |
| Under audit | Individual assets/licensing/security being inspected |
| Accepted for adaptation | Specific asset approved for adaptation after audit |
| Rejected | Not suitable for use |
| Product incorporated | Modified GRIP component with tests and documentation |

---

## SRC-001 — RAD LAB / n8n Local Business Automation Kit

| Field | Record |
|---|---|
| Repository | `radlabischia/n8n-hospitality-templates` |
| Source type | Public GitHub repository / n8n workflows |
| Date registered | 2026-05-30 |
| Initial relevance | High — vertical overlap with GRIP Beauty, Food and Stay |
| Declared verticals | Restaurants, hotels & B&Bs, salons & beauty, medical practices |
| Declared automation themes | Booking/appointment confirmation, reminders, no-show recovery, reviews, weekly reports, win-back campaigns |
| Declared integrations/channels | WhatsApp Business API, Telegram, Email, SMS, Google Calendar, Google Sheets, CRM webhooks |
| Declared n8n compatibility | `>= 1.50.0` according to README |
| License note | README states Apache License 2.0 and additionally instructs clear attribution to RAD LAB and no resale as-is as a closed proprietary product without substantial modifications. Exact license file/audit still required. |
| GRIP use hypothesis | Source of candidate building blocks and workflow patterns; not a sellable GRIP product as provided |
| Current status | Registered — individual workflow audit pending |

### Candidate GRIP mappings

| Source use case | Potential GRIP destination | Priority |
|---|---|---:|
| Salon appointment reminder / rebooking nudge | GRIP Beauty | High |
| Restaurant booking/review workflow | GRIP Food | Medium |
| Hotel pre-stay/review/win-back | GRIP Stay | Medium |
| Medical practice automation | Not initial launch; higher data sensitivity | Hold |

### Mandatory next checks

- List actual JSON workflow files present.
- Fetch and review `LICENSE` and any docs per workflow.
- Inspect credential types, endpoints and any embedded sample data/secrets.
- Determine if workflows are complete/importable or primarily illustrative.
- Record adaptation effort and any security risk.

---

## SRC-002 — Amplify Automation / n8n Automation Templates

| Field | Record |
|---|---|
| Repository | `AmplifyAutomation/n8n-templates` |
| Source type | Public GitHub repository / n8n templates |
| Date registered | 2026-05-30 |
| Initial relevance | Medium/High — premium modules and lead-response patterns |
| Declared template categories | Chatbots, receptionist, speed-to-lead |
| Declared examples | Basic website chatbot with FAQ + Google Calendar; AI chatbot with RAG + CRM sync; Retell AI inbound receptionist + Cal.com; contact-form instant response workflows |
| Declared requirements | n8n plus API credentials depending on template (OpenAI, Google Calendar, Cal.com, etc.) |
| License note | README states templates are freely available for personal and commercial use. Exact asset/license verification still required before incorporation. |
| GRIP use hypothesis | Premium/secondary modules: web chat, instant lead response, CRM sync, later voice reception |
| Current status | Registered — individual template audit pending |

### Candidate GRIP mappings

| Source use case | Potential GRIP destination | Priority |
|---|---|---:|
| Instant response / speed-to-lead | Shared GRIP module | Medium |
| Website FAQ + booking chatbot | Premium add-on | Medium |
| RAG + CRM live sync | Advanced/premium, after initial product | Hold |
| Voice receptionist | Advanced/premium, after validated demand | Hold |

### Mandatory next checks

- List actual JSON assets present.
- Inspect whether workflows rely on unavailable or costly services.
- Inspect security, data-handling and prompt design.
- Determine fit for Argentina/LATAM messaging and payment channels.

---

## Intake rule for all new sources

Any newly discovered repository/template must be added here before any reuse. At minimum record:

1. source and date found;
2. declared license and independently inspected license location;
3. actual files/assets worth auditing;
4. APIs/credentials required;
5. security/data risks;
6. GRIP product mapping;
7. decision and supporting test evidence.
