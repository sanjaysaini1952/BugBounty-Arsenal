# Quick Reference: Recon Commands

## Subdomain Enumeration
```bash
subfinder -d target.com -all -o subdomains.txt
amass enum -passive -d target.com -o amass_subdomains.txt
assetfinder --subs-only target.com > assetfinder_subdomains.txt
findomain -t target.com -q > findomain_subdomains.txt
```

## DNS Resolution
```bash
cat subdomains.txt | dnsx -a -resp-only -o resolved.txt
cat subdomains.txt | dnsx -silent -resp -o dns_records.txt
```

## HTTP Probing
```bash
cat resolved.txt | httpx -silent -status-code -title -tech-detect -o alive.txt
cat resolved.txt | httpx -silent -follow-redirects -o alive_redirects.txt
```

## Port Scanning
```bash
naabu -list alive.txt -top-ports 1000 -o open_ports.txt
nmap -sV -sC -iL alive.txt -oA nmap_results
```

## URL Collection
```bash
cat target.com | waybackurls > wayback.txt
cat target.com | gau > gau.txt
katana -u target.com -d 5 -o katana_urls.txt
```

## JavaScript Analysis
```bash
cat js_urls.txt | linkfinder -i -o cli
cat js_urls.txt | secretfinder -i -o cli
```

## Directory Fuzzing
```bash
ffuf -u https://target.com/FUZZ -w /usr/share/seclists/Discovery/Web-Content/common.txt -mc 200,301,302,403
feroxbuster -u https://target.com -w /usr/share/seclists/Discovery/Web-Content/common.txt
```

## Vulnerability Scanning
```bash
nuclei -l alive.txt -t nuclei-templates/ -severity critical,high,medium -o nuclei_results.txt
```
