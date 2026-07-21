# Hunting Methodology Skill

> General-purpose hunting workflow. Load when: hunting, testing, exploitation, vulnerability hunting.

## Trigger
Load when: hunt, hunt-methodology, bug-hunting, vulnerability-testing, pentest-methodology.

## 7-Question Gate (Validate Before Reporting)
Before submitting ANY finding, answer ALL seven:
1. Is the target explicitly in scope?
2. Is this on the accepted-impact list?
3. Does this affect real users (not just the researcher)?
4. Can you reproduce it with a clean curl command?
5. Is this not already disclosed (check dupcheck)?
6. Does the impact match or exceed the severity claimed?
7. Would a triager agree this is a valid bug?

If ANY answer is "no" or "unsure" — do NOT report. Keep hunting.

## 5-Phase Non-Linear Workflow

### Phase 1: Reconnaissance
Follow skills/recon/SKILL.md. Map the entire attack surface before testing.

### Phase 2: Map & Rank
```
Priority Order:
1. Admin panels / dashboards (auth bypass, IDOR)
2. API endpoints with parameters (injection, IDOR, mass assignment)
3. Authentication flows (OAuth, JWT, session management)
4. File upload functionality (RCE, storage takeover)
5. Payment/subscription flows (business logic, race conditions)
6. Third-party integrations (SSRF, open redirect)
7. JavaScript bundles (secret keys, hidden endpoints, DOM XSS sinks)
8. GraphQL endpoints (introspection, batching, injection)
9. WebSocket connections (CSWSH, injection)
10. Mobile app APIs (deep links, cert pinning bypass)
```

### Phase 3: Hunt
For each endpoint/classification:
- Read the applicable hunting skill (e.g., skills/hunting/xss/SKILL.md)
- Follow the detection patterns and bypass techniques
- Test both authenticated and unauthenticated states
- Chain findings (Bug A → Bug B → Bug C for impact amplification)

### Phase 4: Validate
- Confirm every finding with a reproducible PoC
- Run the 7-Question Gate
- Deep-validate with curl commands
- Check for false positives (scan the same payload 3x minimum)
- Assess actual impact, not theoretical

### Phase 5: Report
- Follow skills/reporting/SKILL.md
- Structure: Title, Severity, Summary, Steps to Reproduce, Impact, Remediation
- Include curl command for reproduction
- Frame impact from the user's perspective
- Map to VRT/CWE/CVSS

## Hunting Rules
1. **Scope First** — Never test out-of-scope assets
2. **No DoS** — Never run aggressive scans without permission
3. **No Data Exfiltration** — Don't access/download unauthorized data
4. **No Persistent Changes** — Don't modify target systems
5. **Document Everything** — Log every attempt, success, and failure
6. **Rate Limit Yourself** — Respect target infrastructure
7. **Chain Findings** — Single bugs are low-value; chains are high-value
8. **Think Like a Developer** — Understand the code to find logic flaws
9. **Test Edge Cases** — Default behavior is tested; edge cases pay
10. **Verify Manually** — Automation finds low-hanging fruit; humans find gold

## Common Anti-Patterns to Avoid
- Running nuclei blindly without understanding findings
- Reporting information disclosure without impact
- Testing XSS with alert(1) instead of contextual payloads
- Reporting default configurations as vulnerabilities
- Not checking for duplicate reports
- Missing auth bypass when testing IDOR
- Forgetting to test with different user roles
- Not checking rate limiting and account lockout

## Attack Chain Templates
### Chain A: Recon → Subdomain Takeover → RCE
1. Find dangling CNAME (subzy)
2. Claim the subdomain on the third-party service
3. Host malicious content
4. Inject phishing credentials or harvest cookies

### Chain B: Open Redirect → OAuth Token Theft
1. Find open redirect parameter
2. Craft redirect to attacker-controlled server
3. Intercept OAuth callback with state/token
4. Use token to access victim's account

### Chain C: SSRF → Cloud Metadata → IAM Theft
1. Find SSRF in URL parameter
2. Probe cloud metadata endpoints (169.254.169.254)
3. Extract IAM credentials
4. Access cloud storage/services with stolen credentials

### Chain D: IDOR → PII Harvesting → Account Takeover
1. Find IDOR in user profile endpoint
2. Enumerate sequential/UUID user IDs
3. Extract PII (emails, phone numbers, hashed passwords)
4. Use PII for credential stuffing or social engineering

### Chain E: XSS → Session Hijacking → Privilege Escalation
1. Find stored XSS in user profile field
2. Inject cookie-stealing payload
3. Capture admin session token
4. Access admin panel with stolen session

### Chain F: Race Condition → Double Spend → Financial Impact
1. Find payment/ordering endpoint
2. Send concurrent requests to same endpoint
3. Exploit TOCTOU to get double credit/item
4. Demonstrate financial loss

## Tool Quick Reference
| Task | Tool |
|------|------|
| Subdomain enum | subfinder, amass, assetfinder, findomain, chaos |
| Live host probe | httpx |
| Port scan | naabu, nmap, masscan |
| URL discovery | waybackurls, gau, katana, hakrawler, waymore |
| JS analysis | LinkFinder, SecretFinder, jshunter, jsleak |
| Param discovery | arjun, paramspider, x8 |
| Directory fuzz | ffuf, feroxbuster, gobuster, dirsearch |
| Vuln scanning | nuclei, nikto, wpscan |
| XSS | dalfox, XSStrike, kxss, Gxss |
| SQLi | sqlmap, ghauri |
| SSRF | SSRFmap, Gopherus |
| SSTI | SSTImap, tplmap |
| Command injection | commix |
| JWT | jwt_tool |
| Subdomain takeover | subzy, subjack, dnsReaper |
| Secrets | trufflehog, gitleaks, SecretFinder |
| Screenshots | gowitness, eyewitness, aquatone |
| WAF detection | wafw00f |
