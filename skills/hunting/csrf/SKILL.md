# CSRF Hunting Skill — 10 Test Cases

> Load when: CSRF, cross-site request forgery, state-changing request, missing CSRF token.

## 88. CSRF on email/password change (easy)
Create a form that auto-submits to `/api/v1/user/email` or `/api/v1/user/password`. Test if change succeeds when victim clicks the link.

## 89. CSRF on account deletion (medium)
Craft a page that submits DELETE request to `/api/v1/user/account`. Report if deletion occurs without confirmation or CSRF token.

## 90. CSRF on admin actions (medium)
Craft requests for admin endpoints (create user, change role, delete data). Test if admin CSRF token is validated.

## 91. CSRF via JSON content type (hard)
If app uses `Content-Type: application/json`, try: `<form enctype="text/plain">` with JSON body, or `navigator.sendBeacon()`.

## 92. CSRF with credentials (hard)
Craft cross-origin request with cookies. If CORS misconfigured, check if response is readable (credential leak).

## 93. CSRF on OAuth flows (medium)
If OAuth callback accepts GET requests with tokens, craft page that auto-submits token to attacker endpoint.

## 94. CSRF via image tag (easy)
If state-changing endpoints accept GET requests: `<img src="https://app.com/api/v1/admin/deleteUser?userId=123">`. Report if GET-based mutation exists.

## 95. CSRF on webhook configuration (medium)
If webhook URL is set via POST, craft page that changes webhook URL to attacker endpoint.

## 96. CSRF via fetch with no-cors (hard)
Use `fetch(url, {method: 'POST', mode: 'no-cors', credentials: 'include'})` to send state-changing request.

## 97. CSRF on file upload (medium)
Craft form that auto-uploads malicious file to user's profile or shared location.

---

## Defense Reference (to report missing controls)
| Defense | Description |
|---------|-------------|
| CSRF Token | Unique token per session, validated server-side |
| SameSite Cookie | `SameSite=Strict` or `Lax` |
| Origin Check | Validate `Origin`/`Referer` headers |
| Custom Headers | Require custom header (e.g., `X-Requested-With`) |
| double-submit | Cookie value must match header value |
