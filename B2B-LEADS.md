# B2B Lead Extractor

## Access and installation

- Administration → B2B Lead Extractor (`/admin/b2b-leads`). Admin and super-admin only; registering does not grant access to the lead database.
- Homepage section: `/#b2b-lead-finder`.
- Existing deployments: run `php cron/migrate-b2b-leads.php` (also included in `cron/migrate.php`). New installations apply migration 009 automatically. Migration is additive and repeatable; it inserts source names, never sample leads.
- PHP requirements match the application; real Excel `.xlsx` exports additionally require `ext-zip` (enabled in this workspace).

## Populate leads

Add a lead manually or upload a UTF-8 CSV. Each upload requires a source, provenance / authorization reference and authorization confirmation. Maximum 2 MB and 1,000 rows per upload. Unknown public business contacts should be blank. CSV headings:

```csv
business_name,category,city,state,website,email,phone
```

Business name and city or state are required. Source and provenance come from the import form. Validation finishes before insertion; any invalid row rejects the import. A normalized business name + city + state fingerprint prevents duplicates across both sources, including concurrent imports. Existing records are skipped without overwriting their data. Shared websites, emails or phone strings are flagged by the duplicate filter for manual review; legitimate branches can share contacts. Slight spelling/address variations may require manual review.

## Live discovery

Use **Extract leads** in the admin module with a keyword, location and marketplace. Discovery reuses the HasData connection in Administration > Settings to search Google-indexed marketplace listings. It uses provider credits and returns up to ten search results, filtered to the selected marketplace and deduplicated by URL. Missing configuration and provider errors appear in the interface. Admin authentication, CSRF and a five-searches-per-five-minutes limit apply.

Choose **Collect data from all listings**, or **Collect lead data** on one result. The collector fetches public listing pages using the existing bounded HTTP client and robots policy, extracting up to 25 businesses per page from JSON-LD, scoped microdata and visible IndiaMART seller cards. Each company keeps its own name, category/product, city, state, full address, website, email and phone. Marketplace support contacts, masked numbers and service areas are not treated as verified business contacts or addresses. Missing fields remain blank. No login or hidden-contact action is automated.

Choose **Review collected lead** to populate the editor, verify the details and save. Source and listing URL are retained as provenance. Full addresses persist through editing, CSV import and CSV/Excel export; existing deployments should rerun `php cron/migrate-b2b-leads.php` for the additive address column. Collection is limited to 20 page requests per admin per five minutes. Failed listings display individual errors and can be retried. The homepage continues to search only the five approved previews.

## Public preview

Open a lead's details and explicitly approve a public slot (1–5). All displayed fields, including any email and phone, must be permitted for public display. Editing a lead automatically clears approval. Remove the old occupant before replacing a slot.

Public searches filter only this fixed five-record cohort across both sources. They never paginate the private database, return private IDs/provenance/notes, or fall back to invented results. Until approved leads exist, the homepage shows an honest empty state. CSRF and per-IP rate limiting apply. The admin database remains accessible only to administrators.

## Management and auditing

Search/filter by keyword, location, category, source, rating, contact availability, dates, favorites and shared contacts. Pagination uses 25 rows. Bulk actions operate on selected rows; delete requires an explicit checkbox. Favorites are shared admin flags. Notes, tags, activity and per-lead audit snapshots are retained. Deleting a lead cascades its notes/tags; activity retains the actor and deleted record ID.

CSV/Excel export respects current filters or an explicit selection, with a 10,000-record cap that fails rather than silently truncating. CSV formula prefixes are escaped; Excel cells are typed as text. Neither export is public.

Analyze Website reuses `SafeHttp`, `Crawler::allowed`, `Crawler::parse`, `Audit::checks` and `Audit::pageScore`. It performs a bounded single-page audit with robots.txt and standard `/sitemap.xml` checks. Network fetches validate public DNS, pin resolved addresses, verify TLS, restrict redirects to the same host, limit response size and respect robots rules. Marketplace domains are blocked. Different-host redirects (including www changes) require updating the lead to its final business website. No project or subscription credits are created/consumed by this focused prospect audit.

Reports include metadata, headings, SSL, HTTP availability, viewport, fetch time and SEO issues. Fetch timing is not Core Web Vitals; viewport presence is not a rendered mobile usability test. HTTP failures/non-HTML responses receive no SEO score. Network/robots failures return an error without replacing the last completed audit; its date remains visible. Audits are limited per admin and per lead. Website edits invalidate the old audit.

Scores: website/email/phone +20 each; complete name/category/city/state +20; verified availability +10; lower audited SEO score +0–10. Hot ≥70, Warm ≥40, otherwise Normal. This ranks contact completeness and potential SEO opportunity, not verified buying intent. Statistics use all leads; New means created within seven days.

## Verification

```text
php tests/b2b-leads.php
php tests/unit.php
node --check assets/js/b2b-leads.js
```

The B2B suite creates a random isolated MySQL database, exercises real HTTP requests, and drops only its own database afterward. It needs database creation privileges. Optional browser checks: `php tests/b2b-leads.php --browser`, using the workspace's `playwright-core` and installed Chrome; `B2B_NODE` and `B2B_CHROME` can override executable paths. Screenshots go to `storage/reports/b2b-*-review.png` and contain isolated test fixtures only.

Back up the new six tables with normal application backups. Apply the organization's retention policy to lead searches and activity. No credentials or uploaded CSV files are retained by the importer.
