FROM ubuntu:latest

# Create a directory for application data
RUN mkdir -p /scanner

# Declare a volume to persist application data
VOLUME ["/scanner"]

WORKDIR /scanner

RUN apt update -y && apt-get upgrade -y
RUN apt-get install -y \
    git \
    wget \
    curl \
    nmap \
    nikto \
    ssh-audit \
    ffuf \
    ldap-utils \
    snmp \
    bind9-host \
    sudo \
    wget \
    tar \
    iputils-ping && \
    nmap --script-updatedb

RUN wget https://go.dev/dl/go1.24.2.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.24.2.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

# Verify installation of go
RUN go version

RUN go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
RUN go install -v github.com/sensepost/gowitness@latest

RUN pip install --upgrade pip setuptools wheel
RUN pip install --upgrade sslyze

RUN rm -rf /scanner/nmapAutomatorNG/*
RUN git clone https://github.com/security-companion/nmapAutomatorNG.git && \
    ln -s /scanner/nmapAutomatorNG/nmapAutomatorNG.sh /usr/local/bin/

# Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Add none admin user, necessary for UDP scan
#RUN  useradd admin && echo "admin:admin" | chpasswd && adduser admin sudo
#USER admin

ENTRYPOINT [ "/bin/bash", "/scanner/nmapAutomatorNG/nmapAutomatorNG.sh" ]
