# API Security Testing Skill — 12 Test Cases

> Load when: API, REST API, GraphQL API, API security, mass assignment.

## 160. Mass assignment via JSON (easy)
Add unexpected fields to JSON body: `{"username": "test", "isAdmin": true, "role": "admin", "credit": 9999}`. Report any fields that are accepted and affect behavior.

## 161. Mass assignment via query params (medium)
Append `?isAdmin=true`, `?role=admin`, `?verified=true` to requests. Report state changes.

## 162. HTTP method confusion (easy)
Test each endpoint with all HTTP methods: GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD, TRACE. Report any unexpected access or data.

## 163. API versioning bypass (medium)
Change API version: `/api/v1/` → `/api/v2/`, `/api/internal/`, `/api/debug/`. Report version-specific vulnerabilities.

## 164. API rate limiting bypass (easy)
Test rate limiting with: different IPs, X-Forwarded-For, X-Real-IP, rotating User-Agent. Report bypass methods.

## 165. Content-Type confusion (medium)
Force JSON endpoint to accept form data, XML, or vice versa. Report parser confusion.

## 166. API enumeration via error messages (easy)
Send invalid data types, missing fields, wrong formats. Report detailed error messages that reveal schema.

## 167. Excessive data exposure (medium)
Check if API returns more data than frontend displays. Compare API response with UI. Report hidden fields.

## 168. BOLA via API path traversal (medium)
Test: `/api/v1/users/1` → `/api/v1/users/2`, `/api/v1/admin/users/1`, `/api/v1/users/1/other-user-data`.

## 169. GraphQL introspection (easy)
Send `{__schema{types{name,fields{name}}}}`. Report full schema disclosure.

## 170. GraphQL batching attack (medium)
Send array of queries in single request: `[{query1}, {query2}, ...]`. Report if batching bypasses rate limiting.

## 171. API key exposure in frontend (medium)
Inspect JS source for API keys, tokens, secrets in hardcoded values, localStorage, cookies.

---

## HTTP Method Testing
| Method | Purpose |
|--------|---------|
| GET | Read data |
| POST | Create data |
| PUT | Replace data |
| PATCH | Partial update |
| DELETE | Remove data |
| OPTIONS | Discover allowed methods |
| HEAD | Check headers without body |
| TRACE | Reflect request (XST) |
