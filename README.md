# BugBounty-Arsenal

<p align="center">
  <strong>The Complete Bug Bounty Hunting Toolkit</strong><br>
  <em>308 test cases across 35 vulnerability categories • 7 AI agents • 100+ tools • Ready-to-use payloads</em>
</p>

<p align="center">
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-vulnerability-categories">Categories</a> •
  <a href="#-ai-agents">Agents</a> •
  <a href="#-use-with-cli-ai-tools">AI Tools</a> •
  <a href="#-tools--scripts">Tools</a> •
  <a href="#-payloads">Payloads</a> •
  <a href="#-contributing">Contributing</a>
</p>

---

## What Is This?

**BugBounty-Arsenal** is a consolidated bug bounty toolkit built from 10+ open-source repositories and extensive real-world hunting experience. It provides everything you need to go from zero to submitted report:

- **308 numbered test cases** across 35 vulnerability categories
- **35 hunting skill files** with step-by-step instructions
- **7 AI-powered agents** for autonomous hunting
- **100+ security tools** with automated installation
- **Ready-to-use payload library** for all major vulnerability types
- **WAF bypass techniques** with 7-level escalation ladder
- **Complete recon pipeline** from subdomain enumeration to vulnerability scanning
- **Report templates** for HackerOne, Bugcrowd, and Intigriti

## Quick Start

### Option 1: Docker (Recommended)
```bash
# Build and run the container
docker-compose up -d bugbounty
docker exec -it bugbounty-kit bash

# Inside the container, run recon
./tools/scripts/recon_full.sh example.com
```

### Option 2: Direct Install
```bash
# Clone the repo
git clone https://github.com/sanjaysaini1952/BugBounty-Arsenal.git
cd BugBounty-Arsenal

# Install all tools (Kali/Ubuntu)
chmod +x tools/scripts/install_all_tools.sh
./tools/scripts/install_all_tools.sh

# Run full recon against a target
chmod +x tools/scripts/recon_full.sh
./tools/scripts/recon_full.sh example.com

# Run vulnerability scan
chmod +x tools/scripts/vuln_scan.sh
./tools/scripts/vuln_scan.sh example.com
```

## Repository Structure

```
BugBounty-Arsenal/
├── README.md                          # You are here
├── LICENSE                            # MIT License
├── CONTRIBUTING.md                    # How to contribute
│
├── skills/                            # Core hunting knowledge
│   ├── hunting/                       # 35 vulnerability categories
│   │   ├── INDEX.md                   # Master index of all 306 test cases
│   │   ├── methodology/               # Complete bug bounty methodology
│   │   │   ├── METHODOLOGY.md         # Full reference document
│   │   │   └── SKILL.md              # Operational hunting workflow
│   │   ├── xss/SKILL.md              # 25 XSS test cases
│   │   ├── sqli/SKILL.md             # 15 SQL injection test cases
│   │   ├── ssrf/SKILL.md             # 15 SSRF test cases
│   │   ├── idor/SKILL.md             # 15 IDOR/BOLA test cases
│   │   ├── csrf/SKILL.md             # 10 CSRF test cases
│   │   ├── api/SKILL.md              # 12 API security test cases
│   │   ├── jwt-oauth/SKILL.md        # 18 JWT/OAuth test cases
│   │   ├── ... (35 categories total)
│   │   └── [see INDEX.md for full list]
│   ├── payloads/SKILL.md             # Master payload library
│   ├── recon/SKILL.md                # 7-phase recon methodology
│   └── reporting/SKILL.md            # Report writing guide
│
├── agents/                            # AI-powered hunting agents
│   ├── autopilot-agent.md            # Full autonomous pipeline
│   ├── recon-agent.md                # Recon specialist
│   ├── xss-hunter.md                 # XSS exploitation expert
│   ├── idor-hunter.md                # IDOR/BOLA specialist
│   ├── ssrf-hunter.md                # SSRF + cloud metadata
│   ├── report-writer.md              # Report authoring
│   └── validation-agent.md           # 7-Question Gate validator
│
├── tools/                             # Automated scripts
│   └── scripts/
│       ├── install_all_tools.sh      # Install 60+ security tools
│       ├── recon_full.sh             # 10-phase recon pipeline
│       └── vuln_scan.sh             # Vulnerability scanner
│
├── dorks/                             # Search dorks
│   ├── google-dorks.md              # 118 Google dork patterns
│   ├── github-dorks.md              # 86 GitHub dork patterns
│   └── shodan-dorks.md              # 68 Shodan dork patterns
│
├── templates/                         # Report templates
│   └── report-template.md            # HackerOne/Bugcrowd template
│
├── rules/                             # Hunting rules
│   ├── hunting-rules.md             # 11 rules (always-on guardrails)
│   └── waf-bypass-protocol.md       # 7-level WAF bypass ladder
│
├── cheat-sheets/                      # Quick references
│   ├── quick-commands.md            # One-liner commands
│   └── engagement-checklist.md      # Full engagement checklist
│
├── wordlists/                         # Curated wordlists
│   ├── wordlists.md                 # 72 sensitive files, 27 API paths, 54 params
│   ├── sensitive-files.txt          # Machine-readable sensitive files list
│   ├── api-endpoints.txt            # Machine-readable API endpoints list
│   ├── parameters.txt               # Machine-readable parameter names list
│   ├── backup-extensions.txt        # Machine-readable backup extensions list
│   ├── subdomains.txt               # Machine-readable subdomain wordlist
│   ├── default-credentials.txt      # Default creds for 20+ services
│   └── default-credentials.md       # Default creds documentation
│
├── commands/                          # Quick reference command cheat sheets
│   ├── recon-commands.md            # Recon one-liner commands
│   ├── exploitation-commands.md     # Exploitation one-liner commands
│   └── validation-commands.md       # Validation & reporting commands
│
├── reports/                           # Example reports
│   ├── example-xss-report.md        # Example XSS report
│   └── example-idor-report.md       # Example IDOR report
│
├── Dockerfile                         # Docker setup
└── docker-compose.yml                 # Docker Compose configuration
```

## Vulnerability Categories

The kit covers **35 vulnerability categories** with **308 numbered test cases**:

### Injection Attacks
| Category | Tests | Key Areas |
|----------|-------|-----------|
| [SQL Injection](skills/hunting/sqli/SKILL.md) | 15 | Error-based, blind, UNION, second-order, NoSQL |
| [Command Injection](skills/hunting/command-injection/SKILL.md) | 3 | Direct, blind, file upload vector |
| [SSTI](skills/hunting/ssti/SKILL.md) | 8 | Jinja2, Twig, Freemarker, WAF bypass |
| [XXE](skills/hunting/xxe/SKILL.md) | 6 | Basic, blind OOB, SVG upload, SOAP |
| [NoSQL Injection](skills/hunting/nosql/SKILL.md) | 3 | MongoDB operators, regex, $where |
| [LDAP Injection](skills/hunting/ldap/SKILL.md) | 3 | Basic, search, filter injection |

### Access Control
| Category | Tests | Key Areas |
|----------|-------|-----------|
| [IDOR/BOLA](skills/hunting/idor/SKILL.md) | 15 | Sequential IDs, UUID, GraphQL, admin panels |
| [Auth Bypass](skills/hunting/auth-bypass/SKILL.md) | 17 | Password reset, 2FA bypass, JWT manipulation |
| [CSRF](skills/hunting/csrf/SKILL.md) | 10 | Email/password change, OAuth, webhooks |
| [CORS](skills/hunting/cors/SKILL.md) | 6 | Origin reflection, null origin, regex bypass |

### Client-Side
| Category | Tests | Key Areas |
|----------|-------|-----------|
| [XSS](skills/hunting/xss/SKILL.md) | 25 | Reflected, stored, DOM, SVG, CSP bypass |
| [Open Redirect](skills/hunting/open-redirect/SKILL.md) | 6 | OAuth callback, URL parsing, CNAME |
| [Prototype Pollution](skills/hunting/prototype-pollution/SKILL.md) | 4 | Basic, XSS, RCE chains |
| [WebSocket](skills/hunting/websocket/SKILL.md) | 4 | XSS, auth bypass, origin bypass |

### Server-Side
| Category | Tests | Key Areas |
|----------|-------|-----------|
| [SSRF](skills/hunting/ssrf/SKILL.md) | 15 | Cloud metadata, DNS rebinding, protocol smuggling |
| [File Upload](skills/hunting/file-upload/SKILL.md) | 12 | Extension bypass, SVG, ZIP slip, ImageMagick |
| [RCE](skills/hunting/rce/SKILL.md) | 10 | eval, deserialization, cron jobs, shared libraries |
| [LFI/Path Traversal](skills/hunting/lfi-path-traversal/SKILL.md) | 6 | Null byte, encoding bypass, log poisoning |
| [Deserialization](skills/hunting/deserialization/SKILL.md) | 5 | PHP, Java, Python pickle, .NET, YAML |
| [Request Smuggling](skills/hunting/request-smuggling/SKILL.md) | 4 | CL.TE, TE.CL, TE.TE, HTTP/2 |

### Application Logic
| Category | Tests | Key Areas |
|----------|-------|-----------|
| [Business Logic](skills/hunting/business-logic/SKILL.md) | 12 | Price manipulation, coupon abuse, step skipping |
| [Race Condition](skills/hunting/race-condition/SKILL.md) | 8 | Double spend, token reuse, OTP bypass |
| [API Security](skills/hunting/api/SKILL.md) | 12 | Mass assignment, method confusion, BOLA |
| [JWT/OAuth](skills/hunting/jwt-oauth/SKILL.md) | 18 | alg:none, key confusion, OAuth redirect, PKCE bypass |
| [GraphQL](skills/hunting/graphql/SKILL.md) | 6 | Introspection, batching, IDOR, depth attack |
| [DoS](skills/hunting/dos/SKILL.md) | 6 | ReDoS, algorithmic complexity, resource exhaustion |

### Infrastructure
| Category | Tests | Key Areas |
|----------|-------|-----------|
| [Subdomain Takeover](skills/hunting/subdomain-takeover/SKILL.md) | 5 | Dangling CNAME, S3, Heroku, GitHub Pages |
| [Cloud/AWS](skills/hunting/cloud/SKILL.md) | 8 | S3 buckets, metadata SSRF, IAM escalation |
| [Security Headers](skills/hunting/security-headers/SKILL.md) | 6 | CSP, HSTS, X-Frame-Options, info disclosure |
| [Web Cache Poisoning](skills/hunting/web-cache-poisoning/SKILL.md) | 6 | Unkeyed headers, cache deception, XSS chains |
| [Crypto](skills/hunting/crypto/SKILL.md) | 6 | Weak hashing, predictable tokens, padding oracle |

### Emerging & Specialized
| Category | Tests | Key Areas |
|----------|-------|-----------|
| [LLM/AI Security](skills/hunting/llm-ai/SKILL.md) | 14 | Prompt injection, data exfiltration, model extraction |
| [Supply Chain](skills/hunting/supply-chain/SKILL.md) | 4 | Dependency vulns, typosquatting, CI/CD injection |
| [Mobile](skills/hunting/mobile/SKILL.md) | 6 | APK reverse, cert pinning, deep links |
| [Recon](skills/hunting/recon/SKILL.md) | 8 | Subdomains, port scan, JS analysis, email harvest |
| [Info Disclosure](skills/hunting/info-disclosure/SKILL.md) | 10 | API responses, error messages, debug endpoints |
| [Cache Attacks](skills/hunting/cache/SKILL.md) | 6 | Header poisoning, cache key injection |
| [Methodology](skills/hunting/methodology/SKILL.md) | -- | 7-Question Gate, attack chains, workflow |

## AI Agents

The kit includes **7 specialized AI agents** for autonomous hunting:

| Agent | Purpose | Usage |
|-------|---------|-------|
| **Autopilot Agent** | Full autonomous pipeline: recon → hunt → validate → report | Load when: full automation requested |
| **Recon Agent** | Elite recon specialist, 10-step passive-to-active pipeline | Load when: recon/enumeration phase |
| **XSS Hunter** | XSS expert with 10-level WAF bypass ladder | Load when: XSS hunting |
| **IDOR Hunter** | IDOR/BOLA specialist, priority endpoint mapping | Load when: IDOR/BOLA hunting |
| **SSRF Hunter** | SSRF + cloud metadata, IAM escalation chain | Load when: SSRF hunting |
| **Report Writer** | Report author with platform-specific formatting | Load when: writing/submitting reports |
| **Validation Agent** | 7-Question Gate validator, enforces quality | Load when: validating findings |

## Use with CLI AI Tools

This toolkit is designed to work with AI-powered CLI tools. Load the skill files as context and let the AI guide your hunting.

### Supported Tools

| Tool | Install | How to Use |
|------|---------|------------|
| **OpenCode** | `npm i -g opencode` | `opencode` then load skill files as context |
| **Claude Code** | `npm i -g @anthropic-ai/claude-code` | `claude` then paste agent/skill content |
| **Gemini CLI** | `npm i -g @google/gemini-cli` | `gemini` then reference skill files |
| **Aider** | `pip install aider-chat` | `aider` with skill files as reference |
| **Cursor** | Download from cursor.sh | Open skill files in editor, use AI chat |

### Step-by-Step: Using OpenCode

```bash
# 1. Install OpenCode
npm i -g opencode

# 2. Navigate to the toolkit
cd BugBounty-Arsenal

# 3. Start OpenCode
opencode

# 4. Load the autopilot agent
# Paste the contents of agents/autopilot-agent.md into the chat

# 5. Start hunting
# Tell the AI: "Hunt XSS vulnerabilities on https://target.com"
# The AI will load skills/hunting/xss/SKILL.md and guide you
```

### Step-by-Step: Using Claude Code

```bash
# 1. Install Claude Code
npm i -g @anthropic-ai/claude-code

# 2. Navigate to the toolkit
cd BugBounty-Arsenal

# 3. Start Claude
claude

# 4. Load context
# Type: "Read agents/recon-agent.md and follow it for target.com"

# 5. The AI will:
# - Run subdomain enumeration
# - Probe for live hosts
# - Scan ports
# - Collect URLs
# - Analyze JavaScript files
# - Return structured results
```

### Step-by-Step: Using Gemini CLI

```bash
# 1. Install Gemini CLI
npm i -g @google/gemini-cli

# 2. Navigate to the toolkit
cd BugBounty-Arsenal

# 3. Start Gemini
gemini

# 4. Load an agent
# Paste agents/ssrf-hunter.md content

# 5. Start SSRF testing
# Tell the AI: "Test https://target.com/fetch?url= for SSRF"
```

### Workflow Example: Full Hunt with AI

```bash
# 1. Start your AI tool
opencode  # or claude, gemini, aider

# 2. Load the autopilot agent
# Paste agents/autopilot-agent.md

# 3. Give the target
> Hunt https://target.com - full scope

# 4. AI will automatically:
Phase 1: Check scope
Phase 2: Run recon (subfinder, httpx, naabu, etc.)
Phase 3: Map and rank targets
Phase 4: Test vulnerability classes
Phase 5: Validate findings with 7-Question Gate
Phase 6: Generate reports

# 5. Review findings
> Show me the XSS findings
> Generate a report for the IDOR vulnerability
> Validate this finding against the 7-Question Gate
```

### Using Individual Skills

```bash
# Load any skill file as context for targeted hunting

# XSS hunting
> Read skills/hunting/xss/SKILL.md and test the search parameter

# SQL injection
> Read skills/hunting/sqli/SKILL.md and test all input fields

# SSRF with cloud metadata
> Read skills/hunting/ssrf/SKILL.md and test for AWS metadata access

# IDOR testing
> Read skills/hunting/idor/SKILL.md and test user profile endpoints

# JWT attacks
> Read skills/hunting/jwt-oauth/SKILL.md and test the authentication flow
```

### Using Payloads

```bash
# Load the payload library for any vulnerability type

> Read skills/payloads/SKILL.md and give me XSS payloads for attribute context

> Read skills/payloads/SKILL.md and give me SSRF bypass techniques

> Read skills/payloads/SKILL.md and give me SQLi WAF bypass payloads
```

### Using Dorks

```bash
# Load dork collections for reconnaissance

> Read dorks/google-dorks.md and find exposed admin panels on target.com

> Read dorks/github-dorks.md and search for leaked API keys

> Read dorks/shodan-dorks.md and find exposed services
```

### AI-Assisted Report Writing

```bash
# Use the report writer agent

> Read agents/report-writer.md and write a report for this XSS vulnerability:
> - Endpoint: https://target.com/search?q=
> - Payload: <script>alert(1)</script>
> - Impact: Cookie theft, session hijacking

# The AI will generate a formatted report for HackerOne/Bugcrowd/Intigriti
```

### Tips for AI-Assisted Hunting

1. **Start with recon** — Load `agents/recon-agent.md` first to map the attack surface
2. **Be specific** — Say "test XSS in the search parameter" not "find bugs"
3. **Load relevant skills** — Each vulnerability class has its own SKILL.md
4. **Validate findings** — Always run the 7-Question Gate before submitting
5. **Chain bugs** — Combine low-severity findings for higher impact
6. **Use payloads** — The `skills/payloads/SKILL.md` has 100+ ready-to-use payloads
7. **Follow methodology** — Read `skills/hunting/methodology/METHODOLOGY.md` for the full workflow

### Example Prompts

```
# Recon
"Run full recon on target.com using the recon agent"
"Enumerate all subdomains of target.com"
"Find all JavaScript files and extract endpoints"

# Vulnerability Testing
"Test for IDOR on all user profile endpoints"
"Check for SSRF in all URL parameters"
"Test JWT authentication for algorithm confusion"
"Scan for XSS in search, comments, and profile fields"

# Validation
"Validate this finding against the 7-Question Gate"
"Is this XSS finding exploitable for account takeover?"
"Calculate CVSS score for this IDOR vulnerability"

# Reporting
"Write a HackerOne report for this SQL injection"
"Generate a PoC curl command for this SSRF"
"Create a step-by-step reproduction guide"
```

## Tools & Scripts

### Install Everything

```bash
./tools/scripts/install_all_tools.sh
```

Installs 60+ tools across categories:

| Category | Tools |
|----------|-------|
| **Subdomain Enum** | subfinder, amass, assetfinder, findomain, chaos |
| **DNS Resolution** | dnsx, massdns |
| **HTTP Probing** | httpx, Aquatone |
| **Port Scanning** | naabu, masscan, nmap |
| **URL Collection** | waybackurls, gau, katana, hakrawler |
| **JS Analysis** | linkfinder, secretfinder, JSFinder |
| **Parameter Discovery** | arjun, paramspider |
| **Directory Fuzzing** | ffuf, gobuster, feroxbuster, dirsearch |
| **Vuln Scanning** | nuclei, sqlmap, nikto, wpscan |
| **XSS** | dalfox, XSStrike |
| **SQLi** | sqlmap, ghauri |
| **CORS** | corsy |
| **Takeover** | subzy, subjack |
| **Secrets** | trufflehog, secretfinder |
| **WAF Detection** | wafw00f |
| **Utilities** | anew, qsreplace, uro, interactsh |

### Recon Pipeline

```bash
./tools/scripts/recon_full.sh <target>
```

Runs a 10-phase automated recon pipeline:

```
Phase 1: Passive subdomain enumeration (crt.sh, subfinder, amass, assetfinder, chaos, findomain)
Phase 2: DNS resolution (dnsx)
Phase 3: HTTP probing (httpx + Aquatone)
Phase 4: Port scanning (naabu)
Phase 5: URL collection (waybackurls, gau, katana, hakrawler)
Phase 6: JavaScript analysis (linkfinder, secretfinder)
Phase 7: Parameter discovery (arjun)
Phase 8: Directory fuzzing (ffuf)
Phase 9: Sensitive file discovery (.env, .git, robots.txt, swagger)
Phase 10: Vulnerability scanning (nuclei)
```

Output saved to `$HOME/bug-bounty/<target>/recon/`

### Vulnerability Scanner

```bash
./tools/scripts/vuln_scan.sh <target>
```

Runs: nuclei (critical+high), subdomain takeover (subzy), XSS (dalfox), SQLi (sqlmap), CORS testing, open redirect fuzzing.

## Payloads

The kit includes a **master payload library** in [`skills/payloads/SKILL.md`](skills/payloads/SKILL.md):

| Category | Count | Highlights |
|----------|-------|-----------|
| XSS | 18 | Event handlers, SVG, polyglots, CSP bypass |
| SQL Injection | 13 | Error-based, blind, UNION, WAF bypass |
| SSRF | 11 | Cloud metadata, DNS rebinding, protocol smuggling |
| SSTI | 6 | Engine-specific templates (Jinja2, Twig, Freemarker) |
| XXE | 4 | Basic, blind OOB, parameter entity |
| LFI | 6 | Null byte, encoding, php://filter |
| Command Injection | 11 | OS commands, backticks, $() substitution |
| CORS | 5 | Origin variants, null, subdomain |
| Open Redirect | 7 | Protocol-relative, URL parsing |
| JWT | 2 | alg:none, weak secret |
| NoSQL | 4 | MongoDB operators |
| Prototype Pollution | 3 | Constructor, __proto__ |
| Header Injection | 5 | CRLF, Host, X-Forwarded-For |
| File Upload | 10 | Extension bypass, double extension |

## Dorks

### Google Dorks (118 patterns)
- Sensitive files (`.env`, `.sql`, `.bak`, `.log`)
- Admin panels, API endpoints, login pages
- Exposed credentials (RSA keys, API keys, client secrets)
- Internal tools (Jenkins, Grafana, Kibana, GitLab)

### GitHub Dorks (86 patterns)
- Secrets in code (`DB_PASSWORD`, `aws_access_key`, `Authorization Bearer`)
- Config files (`.env`, `config.yml`, `settings.py`)
- SaaS secrets (Slack, SendGrid, Twilio, Stripe)

### Shodan Dorks (68 patterns)
- Exposed services with default creds
- API endpoints (Swagger, GraphQL, Kong)
- Databases (MySQL, MongoDB, Redis, Elasticsearch)
- Vulnerability checks (Zabbix, MobileIron, BIG-IP CVEs)

## The 7-Question Gate

Before submitting any report, validate against this gate:

1. **Scope** — Is the target in scope?
2. **Accepted Impact** — Does the program accept this impact type?
3. **Real Users** — Does this affect real users (not just you)?
4. **Reproducible** — Can you reproduce it every time?
5. **Not Duplicate** — Has it been reported before?
6. **Accurate Severity** — Is your severity assessment correct?
7. **Triage Agreement** — Would triagers agree this is valid?

All 7 must pass. No exceptions.

## Hunting Rules

| Rule | Description |
|------|-------------|
| **Rule 0** | Scope is Sacred — never test outside scope |
| **Rule 1** | No DoS — never crash or degrade services |
| **Rule 2** | No Data Exfiltration — don't steal real user data |
| **Rule 3** | No Persistent Changes — don't modify production data |
| **Rule 4** | Document Everything — screenshot, save requests, take notes |
| **Rule 5** | Rate Limit Yourself — be respectful to targets |
| **Rule 6** | Chain Findings — combine low-severity bugs for high impact |
| **Rule 7** | Think Like a Developer — understand how the app works |
| **Rule 8** | Test Edge Cases — boundary values, special characters, timeouts |
| **Rule 9** | Verify Manually — never trust automated tools alone |
| **Rule 10** | Never Submit Without Validation — use the 7-Question Gate |

## WAF Bypass Ladder

When you hit a WAF, escalate through these levels:

| Level | Technique | Example |
|-------|-----------|---------|
| 1 | Basic Encoding | URL encode, double encode, Unicode |
| 2 | Case Variation | `<ScRiPt>`, `SeLeCt` |
| 3 | Null Bytes | `%00`, `<scr%00ipt>` |
| 4 | Alternative Tags | `<img onerror>`, `<svg onload>` |
| 5 | JS Context Bypass | Template literals, array joins |
| 6 | Protocol/Data URIs | `javascript:`, `data:text/html` |
| 7 | Advanced Evasion | Mutation XSS, DOM clobbering, polyglots |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

**Quick contribution ideas:**
- Add new test cases to existing categories
- Create hunting skills for new vulnerability types
- Improve payload libraries
- Add tool installation scripts
- Share recon automation scripts
- Write dork collections for new platforms

## Stats

| Metric | Value |
|--------|-------|
| Vulnerability Categories | 35 |
| Total Test Cases | 308 |
| AI Agents | 7 |
| Payloads | 100+ |
| Google Dorks | 118 |
| GitHub Dorks | 86 |
| Shodan Dorks | 68 |
| Tool Installations | 60+ |
| Recon Pipeline Phases | 10 |
| WAF Bypass Levels | 7 |

## License

MIT License — see [LICENSE](LICENSE) for details.

---

<p align="center">
  <em>Happy Hunting!</em>
</p>
