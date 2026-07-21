# Subdomain Takeover Hunting Skill — 5 Test Cases

> Load when: subdomain takeover, dangling CNAME, abandoned subdomain.

## 197. Dangling CNAME detection (easy)
Resolve all subdomains. Check if CNAME points to unclaimed resource (S3, Heroku, GitHub Pages, Azure).

## 198. S3 bucket takeover (easy)
Check if CNAME points to `*.s3.amazonaws.com` and bucket doesn't exist. Attempt bucket creation.

## 199. Heroku/GitHub Pages takeover (medium)
Check if CNAME points to `*.herokudns.com` or `*.github.io` and app is deleted. Attempt claim.

## 200. Azure takeover (hard)
Check if CNAME points to `*.azurewebsites.net` and app is deleted. Attempt claim.

## 201. Expired domain takeover (hard)
Check if CNAME points to expired domain. Register domain and claim subdomain.

---

## Takeover-able Services
| Service | Fingerprints |
|---------|-------------|
| S3 | `NoSuchBucket`, `NoSuchKey` |
| Heroku | `No such app` |
| GitHub Pages | `404 Not Found` (GitHub-styled) |
| Azure | `Azure Web App - Error` |
| Shopify | `Sorry, this shop is currently unavailable` |
| Fastly | `Fastly error: unknown domain` |
| Heroku DNS | `Heroku DNS error: no such host` |
