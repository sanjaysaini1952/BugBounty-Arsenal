# Cheat Sheet: Quick Commands

## Recon Quick Commands
```bash
# Subdomain enum (all sources)
subfinder -d TARGET -all -silent | anew subs.txt
curl -s "https://crt.sh/?q=%25.TARGET&output=json" | jq -r '.[].name_value' | sort -u | anew subs.txt
assetfinder --subs-only TARGET | anew subs.txt
findomain -t TARGET -q | anew subs.txt

# HTTP probe
cat subs.txt | httpx -silent -sc -td -title | tee alive.txt

# Port scan
cat alive.txt | naabu -silent -top-ports 1000

# URL collection
cat alive.txt | gau | anew urls.txt
cat alive.txt | waybackurls | anew urls.txt
cat alive.txt | katana -silent -d 3 | anew urls.txt

# JS analysis
cat urls.txt | grep "\.js$" | anew js.txt

# Parameter discovery
cat urls.txt | grep "=" | anew params.txt
```

## Vulnerability Quick Commands
```bash
# Nuclei full scan
nuclei -l alive.txt -rl 10 -s critical,high,medium

# XSS
cat urls.txt | grep "=" | dalfox pipe

# SQLi
sqlmap -m urls_with_params.txt --batch --level 5

# SSRF
cat urls.txt | grep "=" | qsreplace "YOUR_COLLAB" | httpx -silent -fr

# Subdomain takeover
subzy run --targets alive.txt

# CORS
curl -s -I -H "Origin: https://evil.com" https://target.com | grep -i "access-control"

# Open redirect
cat urls.txt | grep -Ei "redirect|url|next|return" | qsreplace "https://evil.com" | while read url; do
  curl -s -L -I "$url" | grep -q "evil.com" && echo "VULN: $url"
done

# Sensitive files
cat alive.txt | while read url; do
  for p in .env .git/config robots.txt server-status; do
    code=$(curl -s -o /dev/null -w "%{http_code}" "$url/$p")
    [ "$code" == "200" ] && echo "FOUND: $url/$p"
  done
done
```

## GF Patterns (if installed)
```bash
cat urls.txt | gf sqli      # SQLi candidates
cat urls.txt | gf xss       # XSS candidates
cat urls.txt | gf ssrf      # SSRF candidates
cat urls.txt | gf rce       # RCE candidates
cat urls.txt | gf lfi       # LFI candidates
cat urls.txt | gf redirect  # Redirect candidates
```
