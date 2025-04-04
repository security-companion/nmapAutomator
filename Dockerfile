FROM kalilinux/kali-rolling

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
    nuclei \
    sslyze \
    gowitness \
    ssh-audit \
    ffuf \
    ldap-utils \
    snmp \
    bind9-host \
    sudo \
    wpscan \
    joomscan \
#    droopescan \
#    snmpwalk \
#    ldapsearch \
    smbmap \
    enum4linux \
    odat \
    iputils-ping && \
    nmap --script-updatedb

#RUN apt -y install python3-pip golang

RUN rm -rf /scanner/nmapAutomatorNG/*
RUN git clone https://github.com/security-companion/nmapAutomatorNG.git && \
    ln -s /scanner/nmapAutomatorNG/nmapAutomatorNG.sh /usr/local/bin/

# Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/bin/bash", "/scanner/nmapAutomatorNG/nmapAutomatorNG.sh" ]
