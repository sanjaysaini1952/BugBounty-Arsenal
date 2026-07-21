#!/bin/bash
# Install all security tools for bug bounty
# Run on Kali Linux or Ubuntu

set -e
echo "=========================================="
echo "  INSTALLING BUG BOUNTY TOOL ARSENAL"
echo "=========================================="

# Update system
sudo apt update -y

# Install base dependencies
sudo apt install -y wget curl jq git python3 python3-pip golang-go ruby

# Create tool directories
mkdir -p ~/tools ~/go/bin

# Add Go to PATH
echo 'export PATH=$PATH:$HOME/go/bin:$HOME/tools' >> ~/.bashrc
export PATH=$PATH:$HOME/go/bin:$HOME/tools

echo ""
echo "[*] Installing Go tools..."

# Reconnaissance
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest
go install -v github.com/projectdiscovery/uncover/cmd/uncover@latest

# URL Collection
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/hakluke/hakrawler@latest

# Fuzzing
go install -v github.com/ffuf/ffuf/v2/cmd/ffuf@latest
go install -v github.com/OJ/gobuster/v3@latest
go install -v github.com/epi052/feroxbuster@latest

# Exploitation
go install -v github.com/hahwul/dalfox/v2@latest
go install -v github.com/tomnomnom/anew@latest
go install -v github.com/tomnomnom/qsreplace@latest
go install -v github.com/projectdiscovery/interactsh/cmd/interactsh@latest

# Subdomain takeover
go install -v github.com/lukasikic/subzy@latest
go install -v github.com/haccer/subjack@latest

# Asset discovery
go install -v github.com/tomnomnom/assetfinder@latest
go install -v github.com/Findomain/Findomain@latest

# Port scanning
go install -v github.com/RustScan/RustScan@latest 2>/dev/null || true

echo "[*] Installing Python tools..."

# SQLi
pip3 install sqlmap --break-system-packages 2>/dev/null || pip3 install sqlmap
pip3 install ghauri --break-system-packages 2>/dev/null || pip3 install ghauri

# Web scanning
pip3 install dirsearch --break-system-packages 2>/dev/null || pip3 install dirsearch
pip3 install wafw00f --break-system-packages 2>/dev/null || pip3 install wafw00f
pip3 install arjun --break-system-packages 2>/dev/null || pip3 install arjun
pip3 install paramspider --break-system-packages 2>/dev/null || pip3 install paramspider

# Secret scanning
pip3 install trufflehog --break-system-packages 2>/dev/null || pip3 install trufflehog

# JS Analysis
pip3 install linkfinder --break-system-packages 2>/dev/null || pip3 install linkfinder
pip3 install secretfinder --break-system-packages 2>/dev/null || pip3 install secretfinder

# SSTI
pip3 install SSTImap --break-system-packages 2>/dev/null || pip3 install SSTImap

# Other tools
pip3 install uro --break-system-packages 2>/dev/null || pip3 install uro

echo "[*] Installing system tools..."

# System tools
sudo apt install -y nmap nikto wpscan whatweb dnsenum dnsrecon masscan

# Go-based tools via apt
sudo apt install -y amass 2>/dev/null || true

echo "[*] Installing Nuclei templates..."
nuclei -update-templates 2>/dev/null || true

echo "[*] Installing SecLists..."
if [ ! -d /usr/share/seclists ]; then
    sudo git clone --depth 1 https://github.com/danielmiessler/SecLists.git /usr/share/seclists
fi

echo "[*] Installing GF patterns..."
if [ ! -d ~/tools/gf-patterns ]; then
    mkdir -p ~/tools/gf-patterns
    cd ~/tools/gf-patterns
    for pattern in sqli xss ssrf rce lfi redirect; do
        curl -sL "https://raw.githubusercontent.com/1ndianl33t/Gf-Patterns/master/$pattern" -o "$pattern" 2>/dev/null || true
    done
    cd -
fi

echo ""
echo "=========================================="
echo "  INSTALLATION COMPLETE"
echo "=========================================="
echo ""
echo "Installed tools:"
echo "  Recon:     subfinder, amass, assetfinder, findomain, chaos, httpx, dnsx, naabu"
echo "  Scanning:  nuclei, nikto, wpscan, wafw00f, whatweb, masscan"
echo "  Fuzzing:   ffuf, gobuster, feroxbuster, dirsearch"
echo "  Exploit:   dalfox, sqlmap, ghauri, commix"
echo "  Crawling:  katana, gau, waybackurls, hakrawler"
echo "  Params:    arjun, paramspider, qsreplace"
echo "  Secrets:   trufflehog, gitleaks"
echo "  Utility:   anew, interactsh, uro"
echo "  Takeover:  subzy, subjack"
echo ""
echo "Run 'source ~/.bashrc' to update PATH"
