# Feature verification — 9 September 2026

Application: http://localhost/ppso/

## Changes

- Task forms reject impossible calendar dates.
- Duplicate coupon codes return a validation message instead of a database error.
- Service and AI-credit invoices describe the actual purchase.
- Currency displays preserve nonzero paise.
- Added a background runner for crawls, rankings, scheduled reports, maintenance, and queued email. Its file lock prevents overlapping runs.
- Registered the Windows task `PPSO Background Workers`, then disabled it pending approval to run against live data. The proposed schedule is every five minutes while the Windows user is signed in. XAMPP MySQL must be running; external jobs also need their configured services.

## Verified

Tests used a separate `seo_autopilot_test_review_*` database and a localhost-only server. Production connection settings and customer records were not replaced with test fixtures.

| Suite | Passing checks | Coverage |
| --- | ---: | --- |
| HTTP | 58 | Authentication, registration, recovery, public/project pages, CRUD, reports, PDF, CSV, access checks |
| Workflows | 30 | Remember-me, quotas, atomic imports, tasks, trials, team access, invitations, branding, report email queue |
| Features | 86 | Record add/edit/delete, audit actions, recommendations, internal links, reports, admin forms, SQL export, invoices, signed test payment events, credit fulfillment |
| Browser | 76 | 35 desktop/mobile pages, schema generation, task button, report download, print button, mobile menu, missing-payment-provider feedback |
| Deep checks | 10 | Audit data, invalid payment signatures, amount mismatches, duplicate callbacks, invoice creation, missing SMTP, report escaping |
| Unit | 31 | URL handling, crawler parsing, robots rules, audit scoring, schema generation, escaping |
| XAMPP routing | 47 | Actual `/ppso/` routes, assets, temporary-account login, dashboard/admin access, crawl batching, CSRF and error handling |

The browser sweep reported no JavaScript exceptions or horizontal page overflow. A populated audit report also downloaded successfully as a PDF. Every job in the new background runner exited successfully against the isolated database; unavailable external services were skipped or reported as unconfigured.

## Remaining activation requirements

- AI: endpoint, model, API key.
- Ranking/keyword/backlink services: compatible provider gateway and API key.
- Payments: Razorpay key, secret, and webhook secret; live payment processing has not been exercised.
- Email: SMTP host, sender, and required credentials. Queuing was verified; actual delivery was not.
- Automatic background processing: explicit approval to enable the disabled Windows task. Automatic approval review rejected an immediate live run because it can change data, make network requests, and send queued email.

Provider credentials can be entered in Administration → Settings → Configure server providers. Provider connections cannot be certified until valid credentials and service access are available.

## Reproducing the isolated tests

1. Run `C:\xampp\php\php.exe tests/prepare-review.php` to create a new isolated database and protected review configuration.
2. In a separate PowerShell process set `SEO_CONFIG_FILE` to `C:\xampp\htdocs\ppso\storage\review-config.php`, then run `C:\xampp\php\php.exe -S 127.0.0.1:8086 tests/router.php`.
3. In the test process set the same `SEO_CONFIG_FILE` and set `SEO_TEST_CREDENTIALS` to `C:\xampp\htdocs\ppso\storage\review-credentials.json`.
4. Run `tests/http.php`, `tests/workflows.php`, `tests/features.php`, `tests/deep.php`, and `tests/unit.php` with PHP. These suites must use the isolated database.
5. Run `node tests/browser-review.cjs` with Chrome available. It is restricted to the isolated review server.

The tests generate fixtures and signed test payment events. They never initiate a real payment or send real email. Their artifacts are under the protected `storage` directory.
