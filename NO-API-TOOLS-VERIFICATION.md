# No-API Tools

Directories: `/services` for signed-in users, `/seo-tools` for visitors, and `/admin/tools` for administrators. All 24 tools have individual named cards organized into SEO, Schema, Content, Marketing, Image and Developer categories. Search and category filters hide empty sections. The admin directory keeps the existing administrator authorization check.

Cards open direct forms at `/tools/{id}` or `/admin/tools?tool={id}`, such as `/tools/favicon`. The grouped selector is hidden on direct tool pages. The former `/no-api-tools` and `/admin/no-api-tools` paths open the corresponding card directories. Existing project-based tools remain available. No website selection is required for these utilities.

Processing occurs in the browser. Files and input are not uploaded. The minifier loads a bundled same-origin worker. No CDN or external service is used at runtime. The application itself still needs its normal PHP/database environment for login and navigation.

## Behavior

- QR exports a static PNG with a quiet zone and selectable error correction.
- Sitemaps validate HTTP(S) URLs, deduplicate entries, enforce one origin, escape XML and support last-modified dates. Robots supports multiple agents, allow/disallow rules, sitemap links and a whole-site blocking warning.
- Generic, LocalBusiness and FAQ schema exports JSON-LD. Schema syntax does not guarantee eligibility for search features.
- Metadata uses deterministic templates. SERP rendering is approximate. SEO scoring is a documented, equally weighted checklist over inert pasted HTML, not a live crawl, ranking, performance, or index check.
- Counters and density support Unicode words. Phrase density uses the number of available phrase windows as its denominator.
- Images use native bitmap/canvas processing. PNG, JPG and WebP output is checked for browser encoder support. PNG quality is lossless and ignores the quality slider. Compression is not guaranteed to reduce size; the result reports actual bytes. Resizing supports contain, cover and stretch. Animated input produces a static image. JPEG flattens transparency onto the chosen background.
- Favicon exports PNG or a PNG-backed ICO; ICO sizes above 256 px are rejected. Files are limited to 20 MB; decoded/output images are limited to 40 megapixels.
- Minification runs in a terminable worker. JavaScript preserves names and disables compression transforms; CSS disables restructuring; HTML preserves whitespace and embedded JS/CSS, including whitespace-sensitive content. Inputs are not evaluated.
- Canonical, hreflang and Open Graph generators escape HTML. Redirect output supports Apache site-root rewrite rules and Nginx exact locations, with configuration-character validation. Generated server files are downloaded, never applied automatically.
- Editing fields or switching tools invalidates previous results. Text supports clipboard and file download; image results support file download. Invalid input produces an inline error.

## Local Dependencies

The checked-in `assets/js/local-minifier.js` bundles [Terser](https://github.com/terser/terser) 5.44.0, [CSSO](https://github.com/css/csso) 5.0.5 and [html-minifier-terser](https://github.com/terser/html-minifier-terser) 7.2.0. Licenses are in `assets/js/local-minifier-LICENSE.txt`. The existing local QR library is reused.

Rebuild from the repository root (development only):

```powershell
npm install --prefix storage/no-api-build --ignore-scripts --no-audit --no-fund terser@5.44.0 csso@5.0.5 html-minifier-terser@7.2.0 esbuild@0.25.10
storage/no-api-build/node_modules/.bin/esbuild storage/no-api-build/entry.js --bundle --minify --platform=browser --outfile=assets/js/local-minifier.js --legal-comments=eof
```

## Verification

`node tests/browser-no-api.cjs` uses the existing isolated review database and credentials. It covers all 24 tools, admin login protection, access with no selected website, generated XML and JSON, safe text previews, minifier semantics, decoded QR content, image dimensions/formats, ICO headers, clipboard/download, invalid input and desktop/mobile layouts. It asserts there are no processing network calls except the local worker and application favicon asset.

PHP syntax checks cover changed PHP files; `node --check assets/js/no-api-tools.js` checks the controller. Browser screenshots are written to ignored `storage/test-no-api-*.png` files.
