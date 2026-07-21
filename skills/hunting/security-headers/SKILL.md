# Security Headers Analysis Skill — 6 Test Cases

> Load when: security headers, HSTS, CSP, X-Frame-Options, X-Content-Type-Options.

## 236. Missing security headers (easy)
Check for: `Strict-Transport-Security`, `Content-Security-Policy`, `X-Frame-Options`, `X-Content-Type-Options`, `X-XSS-Protection`, `Referrer-Policy`, `Permissions-Policy`.

## 237. Weak CSP (medium)
Analyze CSP for: `unsafe-inline`, `unsafe-eval`, `*`, `data:`, `blob:`, whitelisted CDN with XSS. Report bypass opportunities.

## 238. Missing HSTS (easy)
Check for `Strict-Transport-Security` header. If missing, report SSL stripping vulnerability.

## 239. Missing X-Frame-Options (easy)
Check for `X-Frame-Options` or CSP `frame-ancestors`. If missing, report clickjacking vulnerability.

## 240. Missing X-Content-Type-Options (easy)
Check for `X-Content-Type-Options: nosniff`. If missing, report MIME sniffing vulnerability.

## 241. Information disclosure in headers (easy)
Check for: `Server`, `X-Powered-By`, `X-AspNet-Version`, `X-Generator`. Report technology disclosure.

---

## Required Security Headers
```
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
Content-Security-Policy: default-src 'self'; script-src 'self'
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
X-XSS-Protection: 1; mode=block
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: camera=(), microphone=(), geolocation=()
```
