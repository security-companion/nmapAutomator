FROM kalilinux/kali-rolling

RUN apt update -y && DEBIAN_FRONTEND="noninteractive" apt install -y kali-linux-headless
#RUN apt install -y kali-linux-headless
RUN export DEBIAN_FRONTEND="noninteractive" apt install -y \
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
#    wpscan \
#    joomscan \
#    droopescan \
#    snmpwalk \
#    ldapsearch \
#    smbmap \
#    enum4linux \
#    odat \
    iputils-ping

#RUN mkdir ~/.nmap/scripts
RUN nmap --script-updatedb

# Create a directory for application data
RUN mkdir -p /scanner

# Declare a volume to persist application data
VOLUME ["/scanner"]

WORKDIR /scanner

#RUN apt -y install python3-pip golang

RUN rm -rf /scanner/nmapAutomatorNG/*
RUN git clone https://github.com/security-companion/nmapAutomatorNG.git && \
    ln -s /scanner/nmapAutomatorNG/nmapAutomatorNG.sh /usr/local/bin/

# Clean
RUN export DEBIAN_FRONTEND="noninteractive" apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/bin/bash"]
#, "/scanner/nmapAutomatorNG/nmapAutomatorNG.sh" 
