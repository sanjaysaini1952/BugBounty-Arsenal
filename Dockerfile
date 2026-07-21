FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    golang-go \
    python3 \
    python3-pip \
    git \
    curl \
    wget \
    nmap \
    dnsutils \
    whois \
    jq \
    unzip \
    build-essential \
    libpcap-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Go tools
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest && \
    go install -v github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install -v github.com/tomnomnom/waybackurls@latest && \
    go install -v github.com/lc/gau/v2/cmd/gau@latest && \
    go install -v github.com/tomnomnom/anew@latest && \
    go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest && \
    go install -v github.com/sensepost/gowitness@latest

# Install Python tools
RUN pip3 install --break-system-packages sqlmap

# Install Go tools (continued)
RUN go install github.com/hakluke/hakrawler@latest && \
    go install github.com/emvan/ffuf/v2@latest && \
    go install github.com/ffuf/ffuf/v2@latest && \
    go install github.com/OJ/gobuster/v3@latest && \
    go install github.com/ropnop/tenstor@latest && \
    go install github.com/KathanP19/GxPF@latest

# Set up wordlists
RUN git clone --depth 1 https://github.com/danielmiessler/SecLists.git /opt/seclists || true

# Set up nuclei templates
RUN nuclei -update-templates || true

# Set up working directory
WORKDIR /workspace

# Copy toolkit
COPY . /workspace/bugbounty-kit/

# Set PATH for Go tools
ENV PATH=$PATH:/root/go/bin

# Default command
CMD ["/bin/bash"]
