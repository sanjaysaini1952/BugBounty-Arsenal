# IDOR / BAC Hunting Skill — 15 Test Cases

> Load when: IDOR, BAC, broken access control, unauthorized access, horizontal privilege escalation.

## 56. Sequential ID enumeration (easy)
For every entity the app returns (orders, users, files, profiles), iterate IDs (`/api/v1/2`, `/api/v1/3`, ...). Report any accessible resources belonging to another user without authentication changes.

## 57. IDOR via UUID prediction (medium)
If IDs are UUIDs, check if they are sequential, time-based (v1), or predictable (v4 from weak RNG). If so, enumerate.

## 58. IDOR via parameter removal (easy)
Remove all authorization headers/cookies. Try `?admin=true`, `?userId=current&target=other`, `?role=admin`. Report any response differences.

## 59. BAC on hidden API endpoints (medium)
Map the API surface: check JS source, swagger, docs. Test each endpoint with and without auth tokens. Report any endpoint that accepts unauthenticated requests.

## 60. IDOR in file downloads (easy)
Change file IDs, file paths, or query parameters when downloading files. Test path traversal in filenames (`../../../etc/passwd`).

## 61. Horizontal privilege escalation (medium)
Create two user accounts. Perform actions on account A, then replay the same request with account B's cookies/headers. Report any data leak or state change.

## 62. Vertical privilege escalation (easy)
Create user and admin accounts. Replay user-level admin requests with admin cookies. Report any endpoint accessible to both roles without proper checks.

## 63. IDOR via JSON body manipulation (easy)
Change `{"userId": 1}` to `{"userId": 2}` in POST/PUT requests. If the app uses the body for authorization, report.

## 64. IDOR in batch operations (medium)
If API supports batch requests (multiple IDs in one call), mix your IDs with other users' IDs. Report cross-user data returned in batch.

## 65. IDOR via GraphQL (hard)
In GraphQL queries, replace node IDs in `node(id: "...")` with other users' nodes. Report any data returned.

## 66. BAC on admin endpoints (easy)
Try accessing `/admin`, `/dashboard`, `/api/admin/users` without auth. Check response codes and content.

## 67. IDOR via API versioning (medium)
Test if changing API version (`/api/v1/` → `/api/v2/`) bypasses access controls. Report differences.

## 68. IDOR in webhook callbacks (medium)
If webhooks include IDs in callbacks, check if those IDs are accessible to other users or if they reveal sensitive data.

## 69. IDOR via shared links (medium)
If app generates shareable links, check if those links expose data to unauthenticated users or if tokens are predictable.

## 70. IDOR in multi-tenant SaaS (hard)
If app serves multiple tenants/organizations, check if changing tenant ID in requests leaks cross-tenant data.

---

## Methodology
1. Create 2+ test accounts at different privilege levels
2. Map all endpoints with their authorization requirements
3. Replay authenticated requests with different user credentials
4. Check for response differences (data, status code, headers)
5. Document all IDOR/BAC findings with reproduction steps
