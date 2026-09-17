# SEO Zentro launch handover

The local application is at http://localhost/ppso/. Production deployment has not been performed.

## Implemented

- SEO Zentro homepage, SVG logo and growth illustration, service landing pages, contact details and responsive styles.
- Separate admin Google Maps, Yelp and Yellow Pages searches, duplicate-safe saved leads and CSV downloads. Searches use protected server credentials. The interface uses neutral service naming.
- Admin blog editor with drafts, publication, safe plain-text content, section headings, image uploads, image descriptions, article metadata and sitemap inclusion.
- Social profile settings under Administration → Settings. Icons remain inactive until official URLs are supplied.
- Existing paid workspace checkout remains under Billing. Public plans send signed-in users there. Lead research is described as a separately quoted managed service, matching its admin-only access.

## Production dependencies

1. Deploy the application and database on a PHP/MySQL host with HTTPS. Set `APP_URL` to the actual public origin (expected https://seozentro.com); the current value is local. Configure DNS and TLS on that host.
2. Run `php cron/migrate-launch.php` on production. This creates additive blog and lead tables. The local migration has run.
3. Configure live Razorpay key, secret and webhook secret in protected configuration or Administration → Settings. Set the provider webhook URL to `/api/v1/webhook` on the production origin. Verify a real authorized checkout and webhook before announcing payments. These credentials are missing locally.
4. Configure SMTP credentials and a verified sender. Test registration, verification, password reset and receipts. SMTP is missing locally.
5. Business leads use `LEADS_API_KEY`, falling back to the existing `RANKING_API_KEY`. A separate key can be saved under Business lead service in provider settings. One live request per source succeeded: Maps 20, Yelp 10, Yellow Pages 30 records. Lead availability depends on the source and credits; emails are not invented.
6. Add actual social profile URLs in Settings. The user has not supplied them.
7. Finalize Terms, Privacy and Refund Policy using the actual business terms. The existing public text identifies these as templates; do not present them as finished policies. Set supported markets, refunds, data retention and business identity accurately.
8. Configure scheduled workers using the existing `cron` commands and verify mail, crawl and ranking jobs on the production host.
9. Verify the domain in Google Search Console and submit `/sitemap.xml`. Review index coverage after launch. No position or indexing deadline is guaranteed.

## Validation

Homepage demos: QR generation, WhatsApp link generation and live chat each allow three anonymous uses. A first-party, HttpOnly `zentro_demo` cookie identifies the browser for up to one year; counters are stored in the existing `rate_limits` table and updated transactionally. Logged-in users are exempt from this demo allowance. QR and WhatsApp content remain client-side, and demo chat content is not sent to the server. Clearing cookies or changing browsers creates a new anonymous identity; this is a trial experience, not identity verification. The cookie policy explains the usage cookie.

`php tests/guest-demos.php` checks independent allowances, fourth-use rejection, session persistence, CSRF, login continuation and public page content. `node tests/demo-browser.mjs` tests the real QR, WhatsApp and chat interfaces plus the expert enquiry dialog and mobile overflow; it requires a disposable Chrome instance on debugging port 9225.

`php tests/launch.php` exercises public routes, admin authentication, CSRF rejection, drafts, publishing/unpublishing, escaped article content, structured data, sitemap visibility, export and lead response normalization. It creates temporary test records and removes them.

`php tests/unit.php` checks existing core URL, crawl, schema and escaping behavior. Application PHP files were syntax checked.

Provider integration references: https://docs.hasdata.com/apis/google-maps/search, https://docs.hasdata.com/apis/yelp/search, https://docs.hasdata.com/apis/yellowpages/search. Maps offsets require coordinates; the first page can search by business type and city alone.
