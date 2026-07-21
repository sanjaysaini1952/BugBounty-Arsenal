# Supply Chain Attack Testing Skill — 4 Test Cases

> Load when: supply chain, dependency, package manager, npm, pip, typosquatting.

## 297. Dependency vulnerability scanning (easy)
Run `npm audit`, `pip-audit`, `trivy fs` on target. Report known vulnerabilities in dependencies.

## 298. Typosquatting detection (easy)
Check package.json/requirements.txt for common typosquatting: `expresss`, `django2`, `flaskk`.

## 299. Malicious package detection (medium)
Check for packages with:
- Few downloads but high version
- Post-install scripts
- Obfuscated code
- Recently changed maintainer

## 300. CI/CD pipeline injection (hard)
Check if CI/CD pipeline:
- Runs untrusted PR code
- Has secrets in environment
- Uses unverified actions
- Has write permissions

---

## Supply Chain Checks
| Check | Tool |
|-------|------|
| Known vulnerabilities | `npm audit`, `pip-audit`, `trivy` |
| Typosquatting | `npm audit signatures` |
| Malicious packages | `socket.dev`, `snyk` |
| CI/CD security | `act`, manual review |
