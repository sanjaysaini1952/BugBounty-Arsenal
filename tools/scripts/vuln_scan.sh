#!/bin/bash
# Quick Vulnerability Scan Script
# Usage: bash vuln_scan.sh target.com

set -e
TARGET=$1
OUTPUT_DIR="$HOME/bug-bounty/$TARGET/vulns"

if [ -z "$TARGET" ]; then
    echo "Usage: bash vuln_scan.sh <target.com>"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

echo "=========================================="
echo "  VULNERABILITY SCAN: $TARGET"
echo "=========================================="

# Quick alive hosts
echo "[*] Finding alive hosts..."
echo "$TARGET" | httpx -silent > alive.txt 2>/dev/null || echo "$TARGET" > alive.txt

# Nuclei - focused scan
echo "[*] Running Nuclei (critical + high)..."
nuclei -l alive.txt -rl 10 -c 50 -s critical,high -o nuclei_critical.txt 2>/dev/null || true

echo "[*] Running Nuclei (medium)..."
nuclei -l alive.txt -rl 10 -c 50 -s medium -o nuclei_medium.txt 2>/dev/null || true

# Subdomain takeover
echo "[*] Checking subdomain takeover..."
subzy run --targets alive.txt 2>/dev/null > subzy_results.txt || true

# XSS scan
echo "[*] Testing XSS..."
echo "$TARGET" | gau 2>/dev/null | grep "=" | dalfox pipe --skip-bav 2>/dev/null > xss_results.txt || true

# SQLi scan
echo "[*] Testing SQLi..."
echo "$TARGET" | gau 2>/dev/null | grep "=" | sort -u | anew sqli_urls.txt 2>/dev/null || true
[ -s sqli_urls.txt ] && sqlmap -m sqli_urls.txt --batch --random-agent --level 3 -o sqli_results.txt 2>/dev/null || true

# CORS test
echo "[*] Testing CORS..."
for origin in "https://evil.com" "null" "https://evil.$TARGET" "https://$TARGET.evil.com"; do
    result=$(curl -s -I -H "Origin: $origin" "https://$TARGET" 2>/dev/null)
    echo "$result" | grep -qi "access-control-allow-origin:.*${origin}" && echo "CORS VULNERABLE: $origin"
done > cors_results.txt 2>/dev/null || true

# Open redirect
echo "[*] Testing Open Redirect..."
echo "$TARGET" | gau 2>/dev/null | grep -aEi "(redirect|url|next|return|dest)=" | qsreplace 'https://evil.com' | while read host; do
    curl -s -L -I "$host" 2>/dev/null | grep -q "https://evil.com" && echo "OPEN REDIRECT: $host"
done > openredirect_results.txt 2>/dev/null || true

# Summary
echo ""
echo "=========================================="
echo "  SCAN COMPLETE: $TARGET"
echo "=========================================="
echo ""
echo "Results in: $OUTPUT_DIR"
echo "  Nuclei critical: $(wc -l < nuclei_critical.txt 2>/dev/null || echo 0)"
echo "  Nuclei medium:   $(wc -l < nuclei_medium.txt 2>/dev/null || echo 0)"
echo "  Subdomain take:  $(wc -l < subzy_results.txt 2>/dev/null || echo 0)"
echo "  XSS:             $(wc -l < xss_results.txt 2>/dev/null || echo 0)"
echo "  SQLi:            $(wc -l < sqli_results.txt 2>/dev/null || echo 0)"
echo ""
echo "[*] Review findings and follow skills/reporting/SKILL.md for reporting."
