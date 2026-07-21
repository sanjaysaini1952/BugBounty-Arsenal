# Reporting & Triage Skill

> Follow this after every finding. A good report = accepted report = bounty paid.

## Report Structure (All Platforms)

### Title Format
```
[Severity] [Vulnerability Type] in [Endpoint/Feature] allows [Impact]
```
Examples:
- `[Critical] SQL Injection in /api/login allows full database access`
- `[High] IDOR in /api/users/{id}/profile exposes PII of all users`
- `[Medium] Open Redirect in OAuth redirect_uri allows account takeover`
- `[Low] Information Disclosure via exposed .git directory`

### Report Sections
1. **Summary** — 2-3 sentences explaining the bug and its impact
2. **Severity** — CVSS score with justification
3. **Affected Endpoint** — URL, parameters, method
4. **Steps to Reproduce** — Numbered steps with curl commands
5. **Proof of Concept** — Screenshots, curl commands, response excerpts
6. **Impact** — Who is affected, what data is at risk, business impact
7. **Remediation** — Specific fix recommendation

## CVSS Scoring Guide
| Severity | CVSS Range | Example |
|----------|-----------|---------|
| Critical | 9.0-10.0 | RCE, SQLi with data exfil, auth bypass |
| High | 7.0-8.9 | IDOR with PII, SSRF to cloud metadata |
| Medium | 4.0-6.9 | Open redirect, CORS misconfig, CSRF |
| Low | 0.1-3.9 | Info disclosure, missing headers |

## 7-Question Gate (Mandatory)
1. Is the target explicitly in scope?
2. Is this on the accepted-impact list?
3. Does this affect real users?
4. Can you reproduce it with curl?
5. Is this not already disclosed?
6. Does the impact match severity claimed?
7. Would a triager agree?

## Platform-Specific Requirements

### HackerOne
- Map to VRT (Vulnerability Rating Taxonomy)
- Include CVSS vector string
- Use `curl` for reproduction
- Include response showing impact

### Bugcrowd
- Map to VRT
- Include "Friendly Tester" language
- Never include real PII in PoC
- Use placeholder data

### Intigriti
- Include CVSS calculator link
- Video PoC recommended
- Write in clear, concise English

## Common Rejection Reasons
- Informational only without impact
- Duplicate of known issue
- Out of scope
- Missing reproduction steps
- Overclaiming severity
- Theoretical vs demonstrated impact
- No user impact (self-XSS, self-DoS)

## Impact Framing
### From User's Perspective
- "An attacker can access any user's private messages"
- "An attacker can change any user's email and take over their account"
- "An attacker can access internal API documentation exposing the entire backend"

### From Business's Perspective
- "This vulnerability could lead to a data breach affecting millions of users"
- "This allows unauthorized access to premium features, causing revenue loss"
- "This exposes internal infrastructure, enabling further attacks"
