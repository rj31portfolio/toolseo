# Domain Ownership & DNS Checker

The tool is enabled and visible by default at `/domain-dns-checker`, directly on Home, and in the existing tool directory. It requires no account, project, API key or paid provider.

Administration > Tools & services contains its name, slug, description, availability and visibility controls. Settings use a single JSON value, `domain_dns_service`, in the existing `settings` table. No database migration is required. Hiding removes the Home interface and directory listing while retaining direct access. Disabling blocks the public page and lookup endpoint. Slug changes update generated links; old slugs return 404. Existing application routes and filesystem paths cannot be selected as slugs.

Registration queries use `https://rdap.org/domain/{domain}` with HTTPS redirects to the registry through the existing SafeHttp client (public-IP validation, pinned resolution, TLS verification, response size cap and bounded timeouts). DNS queries use Google's public JSON DoH API for A, AAAA, CNAME, MX, NS, TXT, SOA and CAA. References: https://about.rdap.org/ and https://developers.google.com/speed/public-dns/docs/doh/json.

RDAP displays registrar, published registrant/organization, registration/expiry/change dates, domain status and nameservers. Missing/redacted information is labeled rather than inferred. Queries use the exact entered domain; subdomain input may need a separate registered-domain lookup. Missing RDAP records do not imply domain availability. DNS distinguishes absent records, NXDOMAIN and upstream errors, filters answers to the requested type and displays TTL and owner name.

The public POST endpoint `/api/v1/domain-dns` uses anonymous-session CSRF protection, strict domain/type validation and the existing IP rate limiter (90 component requests per minute; each full check uses 9). Each component loads independently. Provider failures leave successful results visible. Provider text is rendered with textContent; admin text is escaped. The existing authentication and administrator checks protect configuration changes.

Validation performed:

- `php tests/domain-dns-unit.php`: 86 checks passed, including existing baseline checks, invalid inputs, reserved slugs, RDAP parsing/redaction, all DNS types and provider errors.
- `php tests/domain-dns-live.php`: live RDAP and all eight DNS queries completed for example.com; absent CNAME/CAA records were correctly represented as empty results.
- `node tests/browser-domain-dns.cjs`: public Home/page access, HTTP method and CSRF checks, invalid domain rejection, anonymous live A/RDAP requests, loading state, simulated partial provider failure, safe text rendering, 390px/1440px overflow checks, admin authorization, metadata, custom slug, visibility and disabled page/API checks. Uses the isolated test database and restores original service values.
- PHP lint, JavaScript syntax checks and `git diff --check` passed.

Browser tests default to `http://127.0.0.1:8086` and `storage/test-credentials.json`; override with TEST_BASE and TEST_CREDENTIALS. Use only an isolated test database because the tests temporarily change service settings. The live test needs outbound HTTPS and PHP cURL; international Unicode input needs PHP intl, otherwise enter its ASCII xn-- form. No provider credentials are needed.
