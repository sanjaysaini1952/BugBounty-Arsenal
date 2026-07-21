#!/bin/bash
# Master Recon Script - Full automated recon pipeline
# Usage: bash recon_full.sh target.com

set -e
TARGET=$1
OUTPUT_DIR="$HOME/bug-bounty/$TARGET/recon"
DATE=$(date +%Y%m%d_%H%M%S)

if [ -z "$TARGET" ]; then
    echo "Usage: bash recon_full.sh <target.com>"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

echo "=========================================="
echo "  FULL RECON PIPELINE: $TARGET"
echo "  Output: $OUTPUT_DIR"
echo "=========================================="

# Phase 1: Passive Subdomain Enumeration
echo ""
echo "[*] Phase 1: Passive Subdomain Enumeration"

echo "  [+] crt.sh..."
curl -s "https://crt.sh/?q=%25.$TARGET&output=json" 2>/dev/null | jq -r '.[].name_value' 2>/dev/null | sed 's/\*\.//g' | sort -u > crtsh.txt || true
echo "      Found: $(wc -l < crtsh.txt 2>/dev/null || echo 0) subdomains"

echo "  [+] subfinder..."
subfinder -d "$TARGET" -all -silent 2>/dev/null > subfinder.txt || true
echo "      Found: $(wc -l < subfinder.txt 2>/dev/null || echo 0) subdomains"

echo "  [+] amass (passive)..."
amass enum -passive -d "$TARGET" -timeout 10 2>/dev/null > amass.txt || true
echo "      Found: $(wc -l < amass.txt 2>/dev/null || echo 0) subdomains"

echo "  [+] assetfinder..."
assetfinder --subs-only "$TARGET" 2>/dev/null > assetfinder.txt || true
echo "      Found: $(wc -l < assetfinder.txt 2>/dev/null || echo 0) subdomains"

echo "  [+] findomain..."
findomain -t "$TARGET" -q 2>/dev/null > findomain.txt || true
echo "      Found: $(wc -l < findomain.txt 2>/dev/null || echo 0) subdomains"

echo "  [+] Chaos..."
chaos -d "$TARGET" -silent 2>/dev/null > chaos.txt || true
echo "      Found: $(wc -l < chaos.txt 2>/dev/null || echo 0) subdomains"

echo "  [+] HackerTarget..."
curl -s "https://api.hackertarget.com/hostsearch/?q=$TARGET" 2>/dev/null | cut -d',' -f1 | sort -u > hackertarget.txt || true
echo "      Found: $(wc -l < hackertarget.txt 2>/dev/null || echo 0) subdomains"

# Merge all subdomains
cat crtsh.txt subfinder.txt amass.txt assetfinder.txt findomain.txt chaos.txt hackertarget.txt 2>/dev/null | sort -u | grep -i "$TARGET" > all_subs.txt
echo "  [*] Total unique subdomains: $(wc -l < all_subs.txt)"

# Phase 2: DNS Resolution
echo ""
echo "[*] Phase 2: DNS Resolution"
cat all_subs.txt | dnsx -silent -a -resp-only 2>/dev/null > resolved_ips.txt || true
cat all_subs.txt | dnsx -silent -a -cname -resp 2>/dev/null > dns_records.txt || true
echo "  [*] Resolved IPs: $(wc -l < resolved_ips.txt 2>/dev/null || echo 0)"

# Phase 3: HTTP Probing
echo ""
echo "[*] Phase 3: HTTP Probing"
cat all_subs.txt | httpx -silent -sc -td -title -wc -cdn -follow-redirects 2>/dev/null > httpx_full.txt || true
cat all_subs.txt | httpx -silent -sc -cl -location 2>/dev/null > httpx_simple.txt || true
alive_count=$(cat all_subs.txt | httpx -silent 2>/dev/null | wc -l)
echo "  [*] Alive hosts: $alive_count"

# Phase 4: Port Scanning
echo ""
echo "[*] Phase 4: Port Scanning"
cat all_subs.txt | httpx -silent 2>/dev/null | naabu -silent -top-ports 1000 2>/dev/null > naabu_ports.txt || true
echo "  [*] Open ports found: $(wc -l < naabu_ports.txt 2>/dev/null || echo 0)"

# Phase 5: URL Collection
echo ""
echo "[*] Phase 5: URL Collection"
cat all_subs.txt | httpx -silent 2>/dev/null | waybackurls 2>/dev/null > wayback.txt || true
cat all_subs.txt | httpx -silent 2>/dev/null | gau --threads 5 2>/dev/null > gau.txt || true
cat all_subs.txt | httpx -silent 2>/dev/null | katana -silent -jc -d 3 2>/dev/null > katana.txt || true

cat wayback.txt gau.txt katana.txt 2>/dev/null | sort -u | grep -v '\.(css\|png\|jpg\|gif\|svg\|woff\|ttf\|ico)' > all_urls.txt || true
echo "  [*] Total URLs: $(wc -l < all_urls.txt)"

# Phase 6: JavaScript Analysis
echo ""
echo "[*] Phase 6: JavaScript Analysis"
cat all_urls.txt | grep "\.js$" | sort -u > js_files.txt || true
echo "  [*] JS files found: $(wc -l < js_files.txt 2>/dev/null || echo 0)"

# Phase 7: Parameter Discovery
echo ""
echo "[*] Phase 7: Parameter Discovery"
cat all_urls.txt | grep "=" | sort -u > urls_with_params.txt || true
cat all_urls.txt | httpx -silent 2>/dev/null | arjun 2>/dev/null > arjun_params.txt || true
echo "  [*] URLs with parameters: $(wc -l < urls_with_params.txt 2>/dev/null || echo 0)"

# Phase 8: Directory Fuzzing (light)
echo ""
echo "[*] Phase 8: Directory Discovery"
cat all_subs.txt | httpx -silent 2>/dev/null | head -20 | while read url; do
  ffuf -u "$url/FUZZ" -w /usr/share/seclists/Discovery/Web-Content/common.txt -mc 200,301,302,403 -s -o /dev/null 2>/dev/null | grep "200" | awk '{print $1}'
done > discovered_dirs.txt || true

# Phase 9: Sensitive Files Check
echo ""
echo "[*] Phase 9: Sensitive File Check"
cat all_subs.txt | httpx -silent 2>/dev/null | head -20 | while read url; do
  for path in .env .git/config robots.txt server-status actuator/env swagger-ui.html web.config .DS_Store phpinfo.php; do
    code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$url/$path" 2>/dev/null)
    [ "$code" == "200" ] && echo "FOUND: $url/$path"
  done
done > sensitive_files.txt || true

# Phase 10: Nuclei Scan
echo ""
echo "[*] Phase 10: Nuclei Vulnerability Scan"
cat all_subs.txt | httpx -silent 2>/dev/null | nuclei -rl 10 -bs 35 -c 50 -as -s critical,high -o nuclei_results.txt 2>/dev/null || true
echo "  [*] Nuclei findings: $(wc -l < nuclei_results.txt 2>/dev/null || echo 0)"

# Summary
echo ""
echo "=========================================="
echo "  RECON COMPLETE: $TARGET"
echo "=========================================="
echo ""
echo "Results saved in: $OUTPUT_DIR"
echo ""
echo "File Summary:"
echo "  Subdomains:      $(wc -l < all_subs.txt 2>/dev/null || echo 0)"
echo "  Resolved IPs:    $(wc -l < resolved_ips.txt 2>/dev/null || echo 0)"
echo "  HTTPx full:      $(wc -l < httpx_full.txt 2>/dev/null || echo 0)"
echo "  URLs:            $(wc -l < all_urls.txt 2>/dev/null || echo 0)"
echo "  JS files:        $(wc -l < js_files.txt 2>/dev/null || echo 0)"
echo "  Params:          $(wc -l < urls_with_params.txt 2>/dev/null || echo 0)"
echo "  Sensitive files: $(wc -l < sensitive_files.txt 2>/dev/null || echo 0)"
echo "  Nuclei findings: $(wc -l < nuclei_results.txt 2>/dev/null || echo 0)"
echo ""
echo "[*] Next steps:"
echo "  1. Review nuclei_results.txt for high-severity findings"
echo "  2. Check sensitive_files.txt for exposed files"
echo "  3. Analyze js_files.txt for secrets and endpoints"
echo "  4. Test urls_with_params.txt for injection vulnerabilities"
echo "  5. Check subdomain takeover on all_subs.txt"
