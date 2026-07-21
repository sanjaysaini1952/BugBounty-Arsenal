# Bug Bounty Report Template

---

## Title
[Critical/High/Medium/Low] [Vulnerability Type] in [Endpoint/Feature] allows [Impact]

## Summary
[2-3 sentences explaining what the vulnerability is, where it exists, and what an attacker can achieve.]

## Severity
**[Critical/High/Medium/Low]** — CVSS: [X.X] ([CVSS Vector])

### Justification
[Why this severity rating is appropriate]

## Affected Endpoint
- **URL:** `https://target.com/[endpoint]`
- **Method:** [GET/POST/PUT/DELETE]
- **Parameters:** [list of affected parameters]
- **Authentication Required:** [Yes/No]

## Steps to Reproduce
1. Navigate to `https://target.com/[endpoint]`
2. [Step 2]
3. [Step 3]
4. Observe [what happens]

## Proof of Concept

### Request
```http
[Full HTTP request]
```

### Response
```http
[HTTP response showing the vulnerability]
```

### Curl Command
```bash
curl -X [METHOD] "https://target.com/[endpoint]" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "[parameters]"
```

### Screenshots
[Screenshots demonstrating the vulnerability]

## Impact
[Real-world impact explanation:]
- An attacker can [specific action]
- This affects [who is affected]
- The business impact is [business impact]
- Data at risk: [what data is exposed/compromised]

## Remediation
[Specific fix recommendation:]
- [Concrete fix steps]
- [Security best practice references]

## References
- [OWASP link]
- [CWE: CWE-XXX]
- [CVE: CVE-XXXX-XXXXX (if applicable)]

---
*This report was submitted as part of an authorized bug bounty program.*
