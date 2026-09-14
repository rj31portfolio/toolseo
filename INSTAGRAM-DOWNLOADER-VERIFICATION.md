# Instagram Post & Reel Downloader

Public page: `/instagram-downloader`. Also available directly on Home and in the service directory. No account, project, external API or API key is required.

Administration > Tools & services manages its name, slug, description, availability and Home/directory visibility. Configuration uses `instagram_downloader_service` in the existing settings table; no schema migration is needed. Disabled services block both metadata extraction and media downloads. Both public services reject each other's slugs, including when hidden or disabled.

The server requests only the supplied public Instagram post/reel HTML. Input accepts HTTPS instagram.com or www.instagram.com URLs with `/p/{shortcode}/` or `/reel/{shortcode}/`. Tracking queries and fragments are removed. Page redirects must retain the same post identity. There are no API calls to Instagram, browser automation, authenticated cookies, alternate scraping services or login/CAPTCHA bypasses.

DOM parsing reads Open Graph image/video properties (including URL and secure URL variants), title and page identity. See the [Open Graph specification](https://ogp.me/). Video takes precedence when exposed; a reel without video metadata is shown as an unavailable video with a preview only. No download token or image-download button is issued for it. Carousel enumeration is not supported. Login/private/challenge responses, generic/mismatched pages, missing metadata, HTTP errors and timeouts produce explicit errors.

Downloads are restricted to media URLs extracted by the server on approved cdninstagram.com/fbcdn.net subdomains. Each download requires a random, session-bound token expiring after ten minutes and CSRF validation. URL input cannot turn the download endpoint into an arbitrary proxy. Requests resolve and pin public IPs, verify TLS, reject unsafe redirects, use no cookies and cap files at 50 MB. Temporary files close after use. File bytes are checked with PHP fileinfo; HTML, SVG and mismatched media types are refused. Files are returned as attachments through the same origin. The browser handles download errors without navigating away.

Validation:

- `php tests/instagram-unit.php`: 91 checks passed, including baseline tests, URL/host restrictions, metadata parsing, tracking removal, image-only reels, blocked/private/challenge pages, provider status errors, downloaded-file MIME validation and author-qualified canonical URLs.
- `node tests/browser-instagram.cjs`: Home and standalone guest access, method/CSRF/input validation, forged download tokens, loading, fixture media download, blocked-access errors, safe text rendering, 390px/1440px layout, admin settings, slug conflict, visibility, disabled page/endpoints and admin authorization passed. Browser success/download cases use deterministic fixtures.
- `php tests/domain-dns-unit.php`: 86 existing checks passed.
- PHP lint, JavaScript syntax checks and whitespace checks passed.
- Fixed a false rejection: Instagram returned `/kevin/p/C/` as the canonical og:url for `/p/C/`. The original strict path comparison incorrectly treated this as a different post. Validation now accepts optional author-qualified URLs and compares exact, case-sensitive shortcodes after validating the host and supported path. Post/reel aliases for the same shortcode are accepted; different shortcodes and restricted paths remain rejected.
- `php tests/instagram-live.php https://www.instagram.com/p/C/ --download`: live image metadata and 11,004-byte JPEG download verified.
- `node tests/instagram-http-live.cjs`: full anonymous HTTP flow against http://localhost/ppso passed, including CSRF, metadata extraction, session-bound token and attachment download (11,004 bytes, image/jpeg). This verifies a real image download, not a fixture. Reel video availability still depends on public og:video metadata and Instagram allowing media access.

For browser tests, start the existing isolated test database, configure the test PHP server at http://127.0.0.1:8086 and use storage/test-credentials.json. TEST_BASE and TEST_CREDENTIALS can override these. Tests temporarily edit and restore service settings; do not run them against production. `php tests/instagram-live.php [public-post-url]` performs an optional single anonymous live lookup without retrying through alternate access methods.

Runtime dependencies: existing PHP cURL, DOM, mbstring and fileinfo extensions, outbound HTTPS, working application database for settings/rate limits, and PHP temporary-file storage.

Reel handling regression checks: `node tests/browser-instagram-reels.cjs` passed for unavailable reel previews (no download), fixture MP4 reel downloads, rejection of image responses when video is expected, image-post controls and mobile layout. Existing pre-fix download tokens are invalidated. A current live reel video download has not been verified; the user has not supplied their failing reel URL.
