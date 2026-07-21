# Target Engagement Checklist

## Pre-Engagement
- [ ] Verify program is active on platform
- [ ] Read scope rules completely
- [ ] Note excluded assets and testing restrictions
- [ ] Set up engagement workspace
- [ ] Install and verify all tools
- [ ] Configure rate limits per program rules

## Reconnaissance
- [ ] Passive subdomain enumeration (all sources)
- [ ] DNS resolution
- [ ] HTTP probing / live host detection
- [ ] Port scanning
- [ ] URL collection (Wayback, GAU, Katana)
- [ ] JavaScript analysis
- [ ] Parameter discovery
- [ ] Directory fuzzing
- [ ] Technology fingerprinting
- [ ] Sensitive file checks
- [ ] Subdomain takeover checks
- [ ] Screenshots of live hosts

## Vulnerability Hunting
- [ ] XSS (reflected, stored, DOM)
- [ ] SQL Injection
- [ ] SSRF
- [ ] IDOR/BOLA
- [ ] RCE / Command Injection
- [ ] SSTI
- [ ] XXE
- [ ] CSRF
- [ ] CORS Misconfiguration
- [ ] Open Redirect
- [ ] HTTP Request Smuggling
- [ ] Authentication Bypass
- [ ] Race Conditions
- [ ] Business Logic Flaws
- [ ] Information Disclosure
- [ ] JWT/OAuth vulnerabilities
- [ ] GraphQL attacks
- [ ] File Upload bypass
- [ ] LFI/Path Traversal
- [ ] Web Cache Poisoning

## Validation
- [ ] All findings pass 7-Question Gate
- [ ] Reproducible with clean curl command
- [ ] 3x reproduction minimum
- [ ] Duplicate check on platform
- [ ] Severity accurately assessed

## Reporting
- [ ] Title follows format: [Severity] [Type] in [Endpoint] allows [Impact]
- [ ] Steps to reproduce with curl commands
- [ ] Proof of concept included
- [ ] Impact clearly stated
- [ ] Remediation recommendation provided
- [ ] VRT/CWE mapping included
- [ ] CVSS score calculated

## Post-Submission
- [ ] Monitor for triage feedback
- [ ] Be ready to provide additional info
- [ ] If rejected, understand why and learn
- [ ] Document findings for future reference
