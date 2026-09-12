# Gemini writing tools

Open **AI assistant → AI writing tools**, or use **Content → Open AI writing tools**.

Available tools: ten title ideas, keyword ideas grouped by intent, complete blogs, complete articles, and full-document humanizing. Blog/article targets range from 500 to 2,000 words. Humanizing accepts up to 30,000 characters and preserves the original scope instead of applying the target word count. Results support copying, Markdown download, and transfer into the humanizer. Successful generations are saved in the existing AI conversation history.

Gemini is selected when the configured AI endpoint host is `generativelanguage.googleapis.com`. Existing chat-compatible providers continue to work. The Gemini adapter also serves the existing assistant, page suggestions, and content briefs. Requests retain project authorization, CSRF protection, monthly allowances and purchased-credit accounting.

Protected configuration is in `config/local.php`. Super administrators can replace it using **Administration → Settings → Configure server providers**:

- Provider: AI (Gemini / chat-compatible endpoint)
- Endpoint: `https://generativelanguage.googleapis.com/v1beta`
- API key: a key belonging to an enabled Google AI Studio project
- AI model: `gemini-flash-latest`

No key is embedded in browser scripts or documentation. The adapter uses Google's native `generateContent` request format, system instructions, `x-goog-api-key` header, and usage metadata. Reference: [Google Gemini API](https://ai.google.dev/api/generate-content).

## Verification on 2026-09-12

- `php tests/ai-unit.php`: 58 checks passed (31 existing checks and 27 AI checks).
- PHP syntax checks passed for all modified PHP files; JavaScript syntax check passed.
- `node tests/browser-ai.cjs`: all five writing flows, full-result handoff, Markdown download and provider-error recovery passed using simulated provider responses. No browser JavaScript errors.
- Two live requests with the supplied key reached Google, which returned HTTP 403 `PERMISSION_DENIED`: “Your project has been denied access. Please contact support.” Live successful generation remains unverified and requires Google to enable the project or a replacement key from an enabled project.

The browser check requires local Apache at `http://localhost/ppso`, PHP, Chrome and `playwright-core` in `storage/browser-tools/node_modules`. It uses a rendered fixture and simulated API responses, without changing application records or spending AI credits.
