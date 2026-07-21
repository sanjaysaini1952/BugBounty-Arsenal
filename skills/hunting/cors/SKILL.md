# CORS Misconfiguration Hunting Skill — 6 Test Cases

> Load when: CORS, cross-origin, Access-Control-Allow-Origin, credential leak.

## 180. CORS reflect origin (easy)
Send `Origin: https://evil.com`. If response includes `Access-Control-Allow-Origin: https://evil.com` with `Access-Control-Allow-Credentials: true`, report credential theft risk.

## 181. CORS null origin (easy)
Send `Origin: null` (from iframe sandbox). If accepted, report CORS bypass.

## 182. CORS subdomain wildcard (medium)
If `Access-Control-Allow-Origin: *.example.com`, test attacker-controlled subdomain takeover.

## 183. CORS regex bypass (medium)
If origin is validated via regex (e.g., `^https://.*example.com$`), bypass with `https://evil-example.com` or `https://example.com.attacker.com`.

## 184. CORS preflight bypass (medium)
Check if `Access-Control-Allow-Methods` allows dangerous methods (PUT, DELETE, PATCH) with credentials.

## 185. CORS + credential leak chain (hard)
Chain CORS misconfiguration with API endpoint that returns sensitive data. Demonstrate full data exfiltration from victim.

---

## CORS Testing Methodology
1. Send request with `Origin: https://evil.com`
2. Check if `Access-Control-Allow-Origin` reflects origin
3. Check if `Access-Control-Allow-Credentials: true` is present
4. If yes, use `fetch(url, {credentials: 'include'})` from attacker page
5. Report data leakage
