# Hunting Rules (Always-On Guardrails)

> These rules load into every session. Violating any rule is a hard stop.

## Rule 0: Scope is Sacred
- NEVER test systems without explicit authorization
- NEVER test out-of-scope assets
- ALWAYS verify scope before sending any request
- If uncertain about scope, STOP and ask

## Rule 1: No Denial of Service
- NEVER run aggressive scans without rate limiting
- NEVER use tools that could crash the target
- ALWAYS use `-rl` (rate limit) with nuclei, ffuf, etc.
- Default: max 10 requests/second unless explicitly authorized

## Rule 2: No Data Exfiltration
- NEVER download or store unauthorized data
- NEVER access files, databases, or records beyond what's needed
- NEVER exfiltrate real user data
- Only access the minimum data needed to prove the vulnerability

## Rule 3: No Persistent Changes
- NEVER modify target systems (no defacement, no data changes)
- NEVER create accounts without authorization
- NEVER change passwords or configurations
- NEVER deploy backdoors or persistent access

## Rule 4: Document Everything
- Log every tool invocation and its output
- Save all curl commands that produce findings
- Record timestamps for all test activities
- Maintain evidence for every reported finding

## Rule 5: Rate Limit Yourself
- Respect target infrastructure
- Use delays between requests
- Never exceed program-specified rate limits
- Default: 10 req/s for active scanning, 5 req/s for fuzzing

## Rule 6: Chain Findings for Impact
- Single low-severity bugs rarely get paid
- Look for chains: Bug A + Bug B = Critical
- Open Redirect → OAuth Token Theft = Account Takeover
- SSRF → Cloud Metadata → IAM Theft = Full Cloud Compromise
- IDOR → PII Leak → Account Takeover = Critical

## Rule 7: Think Like a Developer
- Understand the code to find logic flaws
- Read API documentation before testing
- Map the application flow before looking for bugs
- Understand what the developer was trying to do, then find how it breaks

## Rule 8: Test Edge Cases
- Default behavior is always tested by developers
- Edge cases (negative numbers, empty strings, Unicode, very long inputs) are where bugs hide
- Try boundary values, overflow values, special characters
- Test race conditions and concurrency

## Rule 9: Verify Manually
- Automation finds low-hanging fruit; humans find gold
- Every automated finding must be manually verified before reporting
- Never trust scanner output without reproduction
- Build your own payloads, don't just use tool defaults

## Rule 10: Never Submit Without Validation
- Run the 7-Question Gate before every submission
- Verify the finding is reproducible 3 times minimum
- Check for duplicates on the platform
- Ensure impact is real, not theoretical
