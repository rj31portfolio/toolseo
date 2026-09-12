# Local SEO admin and public QR generator

Implemented September 12, 2026.

- `/admin/local-seo`: admin-only website selector, existing manual Local SEO analyzer, saved snapshots, history, JSON-LD and PDF. Fixed PHP alternative-syntax errors in both existing audit views. Admin form submissions and history links retain the admin route. Existing project access and CSRF checks remain in use.
- Applied the idempotent `cron/migrate-local-seo.php` migration to the configured database; existing records are preserved. New installations already include migration 006.
- Homepage `/#free-qr-generator` and `/seo-tools`: 16 static QR types, foreground/background colors, rounded/normal modules, logo, four output sizes, L/M/Q/H correction, PNG/SVG download, image clipboard copy and print view. QR inputs and logos are processed locally; there are no generator network calls or account requirements.
- PDF/file, social and review codes encode existing public links. File hosting is not provided. Crypto codes encode a public wallet address or supplied payment URI. Clipboard image access requires browser support and a secure context (HTTPS or localhost). Print was verified with a browser print-call stub, not a physical printer.

## Verification

`node tests/browser-local-qr.cjs` passed against the isolated review database using headless Chrome:

- All 16 QR payload types decoded from downloaded PNG files using the independent jsQR decoder, including Unicode.
- Rounded QR with a local logo decoded from both PNG and SVG exports.
- Clipboard image copy, print view invocation, mobile layout, contrast validation and invalidating stale output passed.
- Admin form, schema-only generation, saved results/history, PDF signature, server validation, CSRF rejection and anonymous PDF rejection passed.
- PHP syntax checks passed for all changed PHP files; JavaScript syntax check passed.

Browser test dependencies use the existing `storage/browser-tools` installation, plus test-only jsQR 1.4.0 in `storage/browser-tools/jsQR.js`. The test reads the existing isolated review credentials and expects its server on port 8086; do not point it at production.

QR encoder: locally bundled qrcode-generator 1.4.4, MIT, https://github.com/kazuhikoarase/qrcode-generator. License in `assets/js/qrcode-LICENSE.txt`. No runtime CDN dependency.
