# Web Cache Poisoning Skill — 6 Test Cases

> Load when: cache poisoning, cache deception, web cache, CDN.

## 242. Cache poisoning via unkeyed header (medium)
Send `X-Forwarded-Host: evil.com` or `X-Original-URL: /admin`. If response is cached and served to other users, report.

## 243. Cache poisoning via URL path (medium)
Request `/en../?utm_source=x` or similar. If cache key doesn't include path, report poisoning vector.

## 244. Cache poisoning via query string (medium)
If cache ignores query parameters, inject payload: `/?"><script>alert(1)</script>`. Report XSS via cache.

## 245. Cache deception (medium)
Request `/style.css?/admin` or `/static.js?/admin`. If cache serves admin content at static URL, report.

## 246. Cache poisoning via Host header (medium)
Send `Host: evil.com`. If CDN uses Host header for cache key, report poisoning.

## 247. Cache key injection (hard)
If cache key includes user-controlled header, inject payload that matches key. Report cache poisoning.

---

## Cache Poisoning Methodology
1. Identify cache layer (CDN, reverse proxy)
2. Identify cache key (what determines cache hit/miss)
3. Find unkeyed inputs (headers not in cache key)
4. Inject payload via unkeyed input
5. Verify cached response contains payload
6. Verify other users receive poisoned response
