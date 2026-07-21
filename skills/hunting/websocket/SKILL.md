# WebSocket Security Testing Skill — 4 Test Cases

> Load when: WebSocket, WS, WSS, real-time, bidirectional.

## 248. WebSocket XSS (medium)
Send `<script>alert(1)</script>` via WebSocket. If other clients render it unescaped, report stored XSS.

## 249. WebSocket auth bypass (easy)
Connect to WebSocket without authentication. Send commands. Report if auth is not enforced.

## 250. WebSocket origin bypass (medium)
Connect from malicious origin. Report if `Origin` header is not validated.

## 251. WebSocket DoS (medium)
Send large payloads or high-frequency messages. Report if no rate limiting or size limits exist.

---

## WebSocket Testing Commands
```bash
# Basic connection
websocat ws://target.com/ws

# With custom headers
websocat ws://target.com/ws -H "Origin: http://evil.com"

# Send payload
echo '{"type":"message","content":"<script>alert(1)</script>"}' | websocat ws://target.com/ws
```
