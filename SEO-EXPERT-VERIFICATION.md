# Hire an SEO Expert

The independent service is available on the homepage and `/hire-seo-expert`. Administrators use `/admin/seo-expert`, also linked from the admin tabs and sidebar.

## Installation

Run `php cron/migrate-seo-expert.php` for an existing installation. This was run successfully in this workspace. New installations apply migration 008 automatically. The migration creates seven independent `seo_expert_*` tables and can be rerun safely.

## Workflow

- Public enquiries support audit requests, general hiring and preselected plans. Prices are total program amounts; monthly equivalents and savings compare against repeating the three-month plan. All nine requested prices are present.
- Admins can filter and export enquiries, update contact details and lead stages, assign active staff, set follow-ups and proposals, and record notes.
- Active or Completed creates one client profile and initial tasks for the 90-day timeline. Client profiles support dates, notes, tasks, measured ranking entries and report links/summaries. Lead edits synchronize shared profile fields; client dates remain explicitly editable.
- Payments are manually recorded transactions, not an online checkout. Payment status derives from payment history. Pending entries may be resolved; received payments are reversed through refunds. Net paid receipts drive revenue.
- Call, WhatsApp and email links open the appropriate application; they do not automatically send messages.
- The public section includes Service/Offer microdata and the service route is included in the sitemap. No guaranteed ranking claims are made.

## Verification

`php tests/seo-expert.php` creates a random temporary database, starts a local PHP server, and runs Chrome through Playwright. It removes the test database afterward. Requires MySQL database-creation permission, Chrome at the configured executable path and the existing `storage/browser-tools/node_modules/playwright-core` dependency.

Verified: migration reruns, nine prices, savings, month-end dates, CSV formula escaping, responsive homepage, duration selection, public enquiry persistence, unauthenticated admin denial, lead activation, notes, payment persistence, task updates, rankings, reports, dashboard charts and CSV download. Browser screenshots are written to `storage/reports/seo-expert-*.png`.

The existing `php tests/unit.php` suite also passed all 31 checks. Changed PHP files passed syntax checks.
