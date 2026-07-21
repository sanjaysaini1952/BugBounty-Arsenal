# Bug Bounty Methodology — Complete Reference

A practical knowledge base for authorized bug bounty work — reconnaissance, vulnerability classes, tooling, methodology, and reporting.

---

## 1. Foundations

### 1.1 What bug bounty hunting actually is
Bug bounty hunting is authorized security testing performed under an organization's published **scope and rules of engagement**, in exchange for recognition or a monetary reward. It differs from unauthorized hacking only in one critical respect: **explicit permission**. Everything else — the technical skillset, the tools, the mindset — overlaps heavily with penetration testing.

### 1.2 Core ethical/legal ground rules
- **Scope is law.** Only test assets explicitly listed in-scope. Out-of-scope targets, even if owned by the same company, are off-limits without separate authorization.
- **No disruption.** Avoid DoS-style testing, automated scanners at high thread counts against production, or anything that degrades service for real users.
- **No data exfiltration beyond proof.** Demonstrate impact minimally (e.g., one record, a screenshot, a hash) — never dump full databases or user PII.
- **No social engineering unless explicitly permitted** by the program.
- **Report privately** through the platform/program channel; never disclose publicly before the agreed embargo/fix window.
- **Respect rate limits and robots.txt-style courtesy** even when technically bypassable.
- Programs run on platforms like **HackerOne, Bugcrowd, Intigriti, YesWeHack**, or as company-run private/public programs. Some organizations also publish standalone **Vulnerability Disclosure Programs (VDPs)** with no monetary reward but legal safe harbor.

### 1.3 Mindset
Good hunters think in terms of **trust boundaries and assumptions**: everywhere an application trusts input, a session, a role, or another system without re-verifying it, there's a candidate for a bug. The methodology below is built around systematically finding those boundaries.

---

## 2. Pre-Engagement: Reading a Program

Before touching a target:
1. **Read the policy page fully** — in-scope/out-of-scope domains, wildcard rules (`*.example.com` vs specific subdomains), excluded vulnerability classes (many programs exclude self-XSS, clickjacking on non-sensitive pages, missing security headers, rate-limiting issues, etc.).
2. **Check reward table / severity model** — usually mapped to **CVSS** score bands, sometimes a custom priority scale (P1–P5).
3. **Check for safe harbor language** confirming legal protection for good-faith testing within scope.
4. **Look at recently disclosed/resolved reports** (many platforms show a public activity feed) to learn what the program already knows about and what typically gets accepted or duped.
5. **Note testing restrictions**: allowed hours, IP ranges to whitelist, whether staging/test accounts are provided, whether automated scanning requires prior notice.

---

## 3. Reconnaissance (the highest-leverage phase)

Most real findings come from thorough recon, not from exotic exploits. The goal is to build a complete map of the attack surface before testing anything.

### 3.1 Asset & subdomain discovery
- **Passive subdomain enumeration**: `subfinder`, `amass` (passive mode), `assetfinder`, certificate transparency logs (`crt.sh`), Shodan/Censys, DNS aggregators.
- **Active enumeration**: brute-force with `dnsx`/`massdns` against SecLists-style wordlists, permutation tools like `dnsgen` or `alterx` to guess environment-style subdomains (`dev-`, `stage-`, `internal-`, `api-v2-`).
- **Cloud asset discovery**: hunt for exposed S3 buckets, GCS buckets, Azure blobs (`cloud_enum`, manual bucket-name guessing), misconfigured storage permissions.
- **ASN/IP range mapping**: `whois`, BGP tools, Shodan/Censys searches by org name to find infrastructure that isn't in DNS at all.
- **Wayback/historical data**: `gau`, `waybackurls`, `gauplus` to pull historically crawled URLs — often reveals old endpoints, parameters, and forgotten admin panels still live.

### 3.2 Content and endpoint discovery
- **Directory/file brute-forcing**: `ffuf`, `feroxbuster`, `dirsearch`, `gobuster`, using curated wordlists (SecLists' `raft`, `common.txt`, tech-specific lists).
- **Parameter discovery**: `arjun`, `paramspider`, `x8` — finds hidden GET/POST parameters that aren't in visible forms.
- **JavaScript file analysis**: pull all `.js` files (`getJS`, `subjs`) and grep them for API endpoints, hardcoded secrets/keys, internal hostnames, and comments revealing logic. This is consistently one of the highest-yield recon steps against modern SPAs.
- **API surface mapping**: look for Swagger/OpenAPI docs (`/swagger.json`, `/api-docs`), GraphQL introspection (`/graphql` with `__schema` queries), and versioned API paths (`/v1/`, `/v2/`, `/internal/`).
- **Technology fingerprinting**: `whatweb`, `Wappalyzer`, HTTP header analysis, favicon hashing (Shodan's `http.favicon.hash`) to identify frameworks and their known CVEs.

### 3.3 Screenshotting & triage at scale
When recon produces thousands of live hosts, tools like `httpx` (probing), `aquatone`, or `gowitness` take screenshots so a human can rapidly triage which hosts look interesting (login portals, admin panels, staging environments, error pages leaking stack traces).

---

## 4. Core Vulnerability Classes

### 4.1 Injection
- **SQL Injection (SQLi)**: unsanitized input reaching a database query. Test with classic payloads (`'`, `" OR 1=1--`), time-based blind techniques (`SLEEP()`, `WAITFOR DELAY`), and boolean-based blind differential responses. Tool: `sqlmap` for automated exploitation once a candidate parameter is found manually.
- **Command Injection**: input reaching a shell command. Look for functions like `system()`, `exec()`, `popen()` in known tech stacks; test with `; whoami`, backticks, `$()`, and out-of-band techniques (DNS/HTTP callbacks via Burp Collaborator or `interactsh`) when there's no direct output.
- **XXE (XML External Entity)**: applications parsing XML with external entity resolution enabled — can lead to file disclosure or SSRF. Look for any endpoint accepting XML, SOAP, or file formats that embed XML (DOCX, SVG, XLSX).
- **Server-Side Template Injection (SSTI)**: user input rendered into a template engine (Jinja2, Twig, Freemarker). Fingerprint with math-probe payloads like `{{7*7}}` and escalate to RCE depending on engine.
- **NoSQL Injection**: MongoDB-style operator injection (`{"$ne": null}`) in JSON-based login/search forms.

### 4.2 Access Control
- **Broken Object Level Authorization (BOLA/IDOR)**: changing an ID/reference in a request to access another user's data. The single most common high-impact bug class in modern web/API testing — test every endpoint that takes an object identifier by swapping it for another user's ID under a second test account.
- **Broken Function Level Authorization**: a low-privilege user reaching an admin-only endpoint directly (often because the frontend hides the button but the backend doesn't check the role).
- **Privilege escalation**: horizontal (accessing peer accounts) and vertical (gaining higher-privileged capabilities), often via parameter tampering (`role=user` → `role=admin`) or manipulating JWT claims.

### 4.3 Authentication & session management
- Weak password policies, missing account lockout / brute-force protection, predictable password-reset tokens, reset tokens that don't expire or aren't invalidated after use.
- **JWT issues**: `alg:none` acceptance, weak/guessable signing secrets (crackable with `hashcat`/`jwt_tool`), key confusion attacks (RS256→HS256), missing signature verification.
- **Session fixation**, session tokens not rotated after login/privilege change, insecure cookie flags (missing `HttpOnly`, `Secure`, `SameSite`).
- **OAuth misconfigurations**: open redirect in `redirect_uri`, missing `state` parameter (CSRF on OAuth flow), token leakage via referrer headers.

### 4.4 Cross-Site Scripting (XSS)
- **Reflected**: input echoed back in the response unsanitized.
- **Stored**: input persisted and rendered to other users later (higher severity — can hit admins, support agents).
- **DOM-based**: vulnerable JavaScript sink (`innerHTML`, `document.write`, `eval`) processing attacker-controlled data client-side without ever touching the server.
- Testing approach: identify all reflection points, test canary strings, then craft context-appropriate payloads (HTML context, attribute context, JS string context, URL context) — tools: manual testing plus `XSStrike`, Burp's built-in scanner as a starting hint, never as final proof.

### 4.5 Cross-Site Request Forgery (CSRF)
State-changing requests that don't verify a per-session anti-CSRF token or rely solely on cookies. Increasingly mitigated by `SameSite` cookie defaults, so most modern findings live in APIs using custom headers inconsistently, or on subdomains sharing cookie scope.

### 4.6 Server-Side Request Forgery (SSRF)
Application fetches a URL supplied (directly or indirectly) by the user — image-fetch features, webhook configuration, PDF generators, URL preview features are classic entry points. Impact ranges from internal port scanning to reaching cloud metadata endpoints (`169.254.169.254`) for credential theft. Test with internal IPs, `localhost`, alternate encodings (decimal IP, `0x` hex, DNS rebinding) to bypass naive blocklists.

### 4.7 File upload vulnerabilities
Test for: missing extension/content-type validation, double extensions (`shell.php.jpg`), null-byte tricks (legacy stacks), polyglot files, path traversal in filenames, and whether uploaded files are served from a location that executes server-side code. Often called "the winning horse" of web app testing because a bypass frequently leads directly to RCE.

### 4.8 Business logic flaws
Not detectable by scanners — require understanding the application's intended workflow and finding a sequence of legitimate-looking actions that produces an unintended outcome: race conditions in payment/coupon redemption, price manipulation via client-side totals, skipping required steps in a multi-step flow, negative quantity/refund abuse.

### 4.9 Misconfiguration & information disclosure
Exposed `.git` directories, `.env` files, backup files (`.bak`, `~`), verbose error/stack traces, debug endpoints left enabled in production, default credentials, directory listing enabled, exposed cloud storage, leaked API keys/secrets in JS bundles or public repos (search with `truffleHog`, `gitleaks`, `Gitrob` against related GitHub orgs).

### 4.10 Rate limiting & abuse
Missing throttling on login, OTP verification, password reset, or coupon/gift-card brute-forcing endpoints — often chainable into account takeover.

---

## 5. Standard Toolchain (by function)

| Purpose | Tools |
|---|---|
| Proxy / manual testing | **Burp Suite** (Community/Pro), OWASP ZAP |
| Subdomain enumeration | subfinder, amass, assetfinder, findomain |
| DNS resolution/probing | dnsx, massdns, httpx |
| Port/service scanning | **Nmap**, masscan, naabu |
| Content discovery | ffuf, feroxbuster, dirsearch, gobuster |
| Parameter discovery | arjun, paramspider, x8 |
| Historical URLs | gau, waybackurls |
| Vulnerability scanning | **Nuclei** (template-based), Nikto |
| SQLi exploitation | **sqlmap** |
| Secret/credential search | truffleHog, gitleaks, Gitrob |
| OSINT / entity mapping | **Maltego**, Shodan, Censys, Google dorking |
| Password/hash attacks | John the Ripper, Hashcat, Hydra |
| Wireless | Aircrack-ng |
| Network utility | Netcat, Wireshark |
| Post-exploitation (internal pentest) | Mimikatz, Metasploit |
| Mobile app analysis | **MobSF**, apktool, jadx, Frida |
| CMS-specific | WPScan (WordPress) |
| Wordlists | **SecLists** (the standard reference wordlist collection) |
| SSRF/blind-injection OOB detection | Burp Collaborator, interactsh |

**Distros commonly used**: Kali Linux, Parrot Security OS — pre-bundle most of the above.

---

## 6. A Practical End-to-End Methodology

1. **Scope confirmation** — re-read policy, list every in-scope asset.
2. **Passive recon** — subdomains, ASN mapping, historical URLs, GitHub/dork searches, no traffic hits the target yet.
3. **Active recon** — resolve and probe live hosts, screenshot at scale, fingerprint tech stacks.
4. **Content & API discovery** — directory brute-force, JS analysis, parameter mining, API doc discovery.
5. **Manual mapping** — walk the application as a real user (and as multiple roles, if test accounts exist) through Burp, building a full sitemap of functionality and every place user input touches server logic.
6. **Targeted testing per vulnerability class** — work through Section 4 systematically against mapped functionality rather than randomly; prioritize authentication, access control (IDOR/BOLA), and file handling first since they tend to be highest-impact and most common.
7. **Chaining** — many high-severity reports are a chain of individually "low" issues (e.g., an open redirect + a missing `state` param = full OAuth account takeover). Always ask "what else can this touch?"
8. **Proof-of-concept minimization** — capture the smallest reproducible evidence that demonstrates impact.
9. **Write and submit the report** (see Section 7).
10. **Retest after fix** if the program requests validation.

**Note-taking discipline**: log every request/response pair, every tested parameter, and every dead end as you go (Burp's built-in notes, or an external tool like Obsidian/Notion). This prevents re-testing the same thing twice and makes report-writing far faster.

---

## 7. Writing a Report That Gets Paid

A strong report includes:
- **Clear, specific title** (e.g., "IDOR on `/api/v2/orders/{id}` allows viewing any user's order history").
- **Severity/CVSS estimate** with justification.
- **Step-by-step reproduction** — numbered, unambiguous, includes exact requests (raw HTTP where possible).
- **Impact statement** — what a real attacker could do with this, described concretely, not hypothetically inflated.
- **Proof of concept** — screenshot, curl command, or short video; minimal necessary evidence, not a full data dump.
- **Suggested remediation** (optional but appreciated by many programs).
- Avoid duplicate submissions by checking the program's public disclosure feed first when available.

---

## 8. Continuous Learning

- Follow structured methodology write-ups and disclosed reports on **HackerOne Hacktivity** and **Bugcrowd's crowd-sourced** disclosures — real accepted reports are the best training data for pattern recognition.
- OWASP resources (Top 10, Testing Guide, Cheat Sheet Series) are the canonical free reference for vulnerability classes.
- Security certifications relevant to this field: **OSCP, eWPT/eWPTX, CEH, OSWE** — useful for structured skill-building even outside formal exams.
- ExploitDB and CVE feeds for tracking newly disclosed vulnerabilities in common software your targets might run.
