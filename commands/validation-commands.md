# Quick Reference: Validation & Reporting Commands

## Reproduction Verification
```bash
# Save request to file and replay
curl -k -o response.txt -D headers.txt "https://target.com/vulnerable-endpoint"

# Compare responses
diff clean_response.txt vulnerable_response.txt
```

## Impact Verification
```bash
# Check for sensitive data in response
grep -iE "(password|token|secret|key|cookie|session)" response.txt

# Check for admin access
curl -k -H "Authorization: Bearer TOKEN" "https://target.com/admin/api/users"
```

## Screenshot Evidence
```bash
# Take screenshot of vulnerability
gowitness file -f urls.txt -P screenshots/
```

## Report Attachment Prep
```bash
# Create evidence directory
mkdir -p evidence/

# Save all evidence
cp request.txt evidence/
cp response.txt evidence/
cp headers.txt evidence/
cp screenshot.png evidence/
```

## Severity Calculation (CVSS 3.1)
```
Attack Vector: Network (AV:N)
Attack Complexity: Low (AC:L)
Privileges Required: None (PR:N)
User Interaction: None (UI:N)
Scope: Changed (S:C)
Confidentiality: High (C:H)
Integrity: High (I:H)
Availability: High (A:H)
= 10.0 (Critical)
```

## Pre-Submit Checklist
- [ ] 7-Question Gate passed
- [ ] 3x reproduction successful
- [ ] Clean curl command ready
- [ ] Impact clearly demonstrated
- [ ] Remediation provided
- [ ] No sensitive data in report
- [ ] Correct VRT/CWE mapping
- [ ] Severity justified with CVSS
