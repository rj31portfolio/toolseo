# Sitemap and robots.txt generators

Open **All tools & services → Create**, or use the sidebar links for **Sitemap generator** and **Robots.txt generator**. Select the website you are preparing files for.

The sitemap generator accepts up to 1,000 page URLs, removes duplicates, validates the project host/protocol and generates XML with the sitemap namespace. An optional last-modified date is only included when explicitly entered. Saved-page import uses the latest completed audit and excludes non-200, noindex, external and noncanonical pages; the first 1,000 eligible pages are offered when the crawl is larger.

The robots.txt generator supports a shared group of user-agents, optional Disallow/Allow path rules, and absolute sitemap references. Empty rules permit crawling. It highlights a whole-site Disallow rule for review. Robots rules control crawling, not private access or guaranteed removal from search results.

Both generators show the exact generated text with copy/download controls and publishing instructions. They require no AI or third-party API credentials, make no external requests and do not overwrite any hosted files. Endpoints use existing session, website-access and CSRF checks.

## Checks

- `php tests/seo-files-unit.php`: 57 checks passed, including 26 new generator checks.
- `node tests/browser-seo-files.cjs`: real local API generation, XML parsing, robots rules, saved-page import, copy/download contents, mobile layout, invalid-input preservation, CSRF and missing-project protection.
- `node tests/browser-design.cjs`: menu routes and service filters updated for 18 tools, including both generators.
- PHP/JavaScript syntax checks passed.

Format references: [Sitemap protocol](https://www.sitemaps.org/protocol.html), [Google robots.txt instructions](https://developers.google.com/crawling/docs/robots-txt/create-robots-txt).
