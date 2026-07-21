# Denial of Service Hunting Skill — 6 Test Cases

> Load when: DoS, denial of service, resource exhaustion, amplification.

## 301. ReDoS (Regular Expression Denial of Service) (easy)
Send crafted input that causes catastrophic backtracking: `aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!` to regex. Report if response time >5s.

## 302. Algorithmic complexity attack (medium)
Send input that triggers worst-case O(n²) or O(2^n) behavior: deeply nested JSON, long strings, many keys.

## 303. Resource exhaustion via upload (easy)
Upload very large files (1GB+). Check if server processes entire file before rejecting. Report bandwidth amplification.

## 304. Connection exhaustion (medium)
Open many connections without completing handshake. Check if server limits concurrent connections.

## 305. Memory exhaustion (medium)
Send very large JSON/XML payloads, deeply nested objects, many parameters. Report memory consumption.

## 306. API rate limiting bypass (medium)
Test rate limiting with: different IPs, X-Forwarded-For, rotating User-Agent, distributed requests.

---

## DoS Detection
| Indicator | Description |
|-----------|-------------|
| Slow response | High CPU/memory usage |
| Timeouts | Resource exhaustion |
| Connection refused | Connection limit reached |
| 502/503 errors | Backend overwhelmed |
