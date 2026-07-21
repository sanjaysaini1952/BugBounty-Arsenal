# Information Disclosure Hunting Skill — 10 Test Cases

> Load when: information disclosure, sensitive data, data leakage, exposure.

## 265. Sensitive data in API responses (easy)
Check all API responses for: full email, phone, address, SSN, credit card, internal IPs, source code, debug info.

## 266. Sensitive data in error messages (easy)
Trigger errors with invalid input. Check for: stack traces, database errors, internal paths, version info.

## 267. Sensitive data in headers (easy)
Check response headers for: `Server`, `X-Powered-By`, `X-AspNet-Version`, `X-Generator`, `X-Runtime`.

## 268. Source code disclosure (medium)
Check for: `.git`, `.env`, `.DS_Store`, `web.config`, `application.properties`, backup files.

## 269. Directory listing (easy)
Navigate to directories without index files. Check if directory listing is enabled.

## 270. Sensitive files exposure (easy)
Check for: `/robots.txt`, `/sitemap.xml`, `/.env`, `/config.json`, `/package.json`, `/composer.json`.

## 271. Debug endpoints (easy)
Check for: `/debug`, `/console`, `/admin`, `/phpinfo.php`, `/_profiler`, `/.well-known/`.

## 272. Version information disclosure (easy)
Check for version info in headers, error messages, HTML comments, JavaScript files.

## 273. Internal IP disclosure (medium)
Check for internal IPs in: response bodies, error messages, JavaScript files, HTML comments.

## 274. API key exposure in frontend (medium)
Inspect JavaScript source for: API keys, tokens, secrets, passwords in localStorage, cookies, hardcoded values.

---

## Sensitive Files to Check
```
/robots.txt
/sitemap.xml
/.env
/config.json
/package.json
/composer.json
/.git/config
/web.config
/phpinfo.php
/.DS_Store
/debug
/console
/admin
/.well-known/
```
