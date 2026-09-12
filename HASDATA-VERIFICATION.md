# Google ranking integration — 10 September 2026

Open http://localhost/ppso/rankings, select a website, add keywords, and choose **Check Google rankings**. The supplied key is saved only in protected `config/local.php`; the browser never receives it.

The adapter follows [HasData's Google SERP quickstart](https://docs.hasdata.com/apis/google-serp-api/quickstart): GET requests, an `x-api-key` header, and `organicResults` parsing. It sends each keyword's country, language, and device. Checks now paginate through **up to 100 organic positions**, stopping when the target is found or Google provides no further pages. Page-relative positions are converted to overall positions using the requested offset. Domain tracking includes subdomains; an explicit target URL matches that page. Unknown country names produce guidance to use a two-letter code.

Live results are saved once per keyword per UTC day. Repeating a check returns the saved result. New checks use the `hasdata_top100` source so old first-page checks cannot block a deeper check. Missing results have a null position; failed requests preserve earlier data and never become false missing rankings. Per-keyword database locks prevent duplicate concurrent calls. The existing ranking worker uses the same adapter and persistence service; this change does not enable the previously disabled Windows scheduled task.

The ranking dashboard includes current positions, changes, search filters, country/device context, history date filters, and a 90-day trend. Shared dashboard styles improve cards, spacing, navigation, tables, focus indicators, and mobile layouts. The Keywords page and overview link directly to ranking checks.

## Verified

- Two live HasData searches for Coffee returned Wikipedia at position 1, including a complete browser-to-API-to-database check in an isolated database.
- 45 combined unit/ranking checks: audience mapping, domain and target-page matching, lookalike hosts, best position, missing results, malformed responses.
- 9 ranking HTTP checks: CSRF, project scoping, cached results, unique daily history, actionable validation, preservation of earlier results, and no key in page HTML.
- Existing suites: 58 HTTP checks, 30 workflow checks, 86 feature checks, 10 deep checks, and 76 desktop/mobile browser checks passed.
- Additional ranking browser checks passed for live results, failure/retry feedback, filtering, caching, and desktop/mobile layouts. No JavaScript exceptions or horizontal page overflow were detected.
- PHP lint passed for 81 application files; JavaScript syntax passed.

AI generation, keyword research metrics, backlink enrichment, payments, and outgoing email still require their separate provider configuration. Their unavailable-provider handling and applicable local workflows were tested; HasData SERP credentials do not activate those services.

## Reproduce live ranking tests

Use the isolated review environment prepared by `tests/prepare-review.php`, with `SEO_CONFIG_FILE` set to `storage/review-config.php` and the PHP test server on 127.0.0.1:8086. Run the existing HTTP suite to seed its primary website before the ranking tests.

`tests/ranking-setup.php` explicitly copies the protected HasData settings into the isolated review configuration and creates a separate Wikipedia keyword fixture. Run `node tests/browser-rankings.cjs`, then `php tests/ranking-http.php`. A fresh live test uses account credits. Clear `RANKING_ENDPOINT` and `RANKING_API_KEY` from the review configuration afterwards. They were cleared after this verification; the application configuration remains connected.

## Position display fix

The original first-page-only search missed a live match on page three. Rechecking the two actual project keywords saved position **26** for ?Best Digital Marketing Agency in Budhh Vihar?; the Delhi keyword was not found in the available results checked up to position 100. No rank was invented for the missing result.

Positions now also appear in the Keywords table. Ranking history uses explicit missing/unchecked labels instead of blank dashes. The JavaScript URL is versioned so browsers pick up updated checking behavior.

Validation: 54 combined unit/ranking checks, the 76-check browser sweep, and a focused desktop/mobile regression for numeric positions, missing/unchecked states, history and old-cache eligibility all passed. `tests/position-setup.php` prepares synthetic display fixtures in the isolated review database; `tests/browser-positions.cjs` checks them without live API requests.
