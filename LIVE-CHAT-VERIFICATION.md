# Live Chat & Lead Capture

## Getting started

Open `/live-chat` while signed in. Any active registered account can create widgets; no SEO website/project record or separate subscription is required. Existing users, subscriptions, authentication, plans, notifications and admin roles are reused. Administration > Tools & services shows the feature and installation status.

1. In **Chat Widgets**, create a business, enter the public business summary, and add exact website origins such as `https://example.com` and `https://www.example.com`.
2. Customize primary color, launcher shape, position, size, business name, HTTPS logo, avatar label, welcome/placeholder/offline messages, availability, device visibility, branding and required/optional/hidden lead fields. At least email or phone must be required. Text contrast adapts to the primary color.
3. Add confirmed FAQs and matching keywords in **Business Knowledge**. Entries can be added, edited and removed. Unknown questions get an honest fallback asking for a follow-up; this is a deterministic knowledge assistant, not generative AI.
4. Copy **Embed Code** into the site's custom-code area or before `</body>`:

```html
<script src="https://YOUR-DOMAIN/chat-widget.js" data-widget="UNIQUE_WIDGET_ID" defer></script>
```

The generated code includes the actual application path, including `/ppso` where applicable. Plain browser JavaScript works with PHP, WordPress, Shopify theme custom code, Laravel, React and static HTML without framework installation. The platform must permit custom scripts. For remote customer sites the service needs a publicly reachable HTTPS address; `localhost` only works on the same machine. Strict customer CSP must allow the service in script-src, style-src and connect-src and any logo origin in img-src.

## Visitor and owner flow

The widget loads configuration before opening; a conversation is created only when opened. It explains the business first, answers from confirmed knowledge and provides follow-up capture. After two visitor messages the contact prompt becomes more prominent. Closing an engaged conversation first offers contact capture, while still allowing visitors to leave without submitting.

Name, phone, email, interested service/product and optional message are collected with explicit consent. Required fields and contact formats are enforced server-side. Leads are saved once per conversation, scored and assigned New/Contacted/Qualified/Converted status. The owner can edit status and internal notes, inspect contact details and consent time, and open the transcript. Contacts are visitor-provided and not independently verified.

Conversations support business-assistant, human and closed modes. A dashboard reply switches to human mode, pausing automatic replies; visitors receive it within about five seconds while chat is open. Owners refresh the conversation view to read new visitor messages. Offline mode displays the configured message and still accepts visitor messages and follow-up requests. Visitors can resume a session in the same tab; tokens expire after seven days. History remains in the owner's account.

Automation rules can be added, edited, disabled or removed. The first enabled rule whose minimum score and optional service/message keyword match runs once when the lead is created. Existing leads are not retroactively modified. Optional lead notifications are in-app only; no email, SMS, webhook or external messaging service is invoked.

Analytics use actual saved data: conversation count, lead count, conversation-to-lead capture rate, converted leads, average lead score and seven-day lead totals in UTC. Score is a transparent 0–100 heuristic: name 15, email 25, phone 25, service 20, message 5, and a quote/buy/book/demo/pricing/purchase term 10. It is not a conversion-probability model.

## Home demo

Home includes **Live Chat & Lead Capture** with an animated launcher/message treatment and an interactive Bloom Studio demo, using the same widget implementation. Demo answers and form submissions stay in memory; contact details are never saved or sent. It does not create production conversations or leads. It honors reduced-motion preferences and does not steal focus or scroll the page on load.

## Storage and installation

Migration: `database/migrations/007-live-chat.sql`. The migration was applied to the configured local application database and is included in fresh installations. For another existing deployment run:

```shell
php cron/migrate-live-chat.php
```

Alternatively, a super administrator can use **Install chat storage** in Administration > Tools & services. The migration is additive and safe to rerun, with these six tables:

| Table | Purpose |
| --- | --- |
| chat_widgets | Owner, public embed ID, business summary, appearance, allowed origins |
| chat_knowledge | Confirmed answers and matching keywords |
| chat_conversations | Widget, hashed visitor token, origin, mode, expiry |
| chat_messages | Ordered transcript, sender role, client request ID |
| chat_leads | Contact details, consent, score, status, internal notes |
| chat_automation_rules | Ordered lead-status conditions and actions |

Foreign keys preserve ownership relationships. Existing `users`, `subscriptions` and `notifications` tables remain authoritative; no parallel account or billing system is created. Records are retained for dashboard history; include these tables in normal database backups and your data-retention procedures.

## Isolation, security and performance

- CSS is contained in Shadow DOM and JavaScript uses a local closure. This isolates normal customer CSS/JS conventions; it is not a security sandbox against the embedding site itself. See [MDN Shadow DOM](https://developer.mozilla.org/en-US/docs/Web/API/Web_components/Using_shadow_DOM).
- Widget requests use `credentials: omit`, exact-origin CORS and random visitor tokens rather than third-party cookies. Tokens are stored only in sessionStorage when available, hashed in the database, bound to widget and origin, and expire after seven days. Public widget IDs are intentionally public and are not authentication credentials. See [MDN CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CORS).
- Dashboard actions retain existing authentication, CSRF validation, audit logging and owner-scoped reads/writes. Cross-owner widget, lead and conversation access is rejected before page output.
- Public requests have bounded JSON/message lengths and IP rate limits. A locked conversation and unique request/lead keys prevent duplicate messages and leads on retries. Messages and business text render as text, not HTML.
- The script is approximately 12 KB uncompressed and has no runtime library dependencies. Polling runs only for an open, visible widget, requests only new messages, and stops when the widget is detached. No polling or storage occurs for the Home demo.
- Practical caps: 50 widgets per account, 100 knowledge entries and 50 rules per widget, about 290 transcript messages per conversation. Leads are paginated; recent conversations and notifications show the latest 100 records.

## Verification

- `php tests/chat-unit.php`: 47 checks, including existing baseline checks, origin validation, confirmed knowledge/fallback behavior, lead consent and contact validation, and scoring.
- `node tests/chat-http.cjs`: passed against an isolated test database at both a root URL and `/ppso`. Covers widget creation/update, knowledge/rule editing, owner isolation, exact-origin CORS, anonymous start, knowledge replies, idempotency, token/origin isolation, lead validation, scoring and automation, lead status, notifications, human replies, all dashboard tabs, embed code and disabling.
- `node tests/browser-chat.cjs`: passed with headless Chrome using a separate customer origin and intentionally conflicting CSS. Covers Home demo, no automatic page scroll, mobile embed, confirmed answer, consent and saved lead, session resume, live team reply, analytics and mobile settings. Screenshots are in `storage/chat-*.png`.
- PHP lint, JavaScript syntax and whitespace checks passed.

Tests use isolated `seo_autopilot_test*` databases and generated test accounts. `tests/chat-setup.php` refuses production databases. Generated credentials and widget IDs use ignored `storage/test-chat-*.json` paths. Run setup, the test PHP server, HTTP tests, `node tests/chat-host.cjs` (customer origin on port 8091), then browser tests. The HTTP test supports TEST_BASE for a nested application URL. Tests must not be run against production because they create widgets, conversations and leads.
