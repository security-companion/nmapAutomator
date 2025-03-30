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
    ffuf \
    ldap-utils \
    snmp \
    bind9-host \
    sudo \
    iputils-ping && \
    nmap --script-updatedb

RUN rm -rf /scanner/nmapAutomator/*
RUN git clone https://github.com/security-companion/nmapAutomator.git && \
    ln -s /scanner/nmapAutomator/nmapAutomator.sh /usr/local/bin/

# Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Add none admin user, necessary for UDP scan
#RUN  useradd admin && echo "admin:admin" | chpasswd && adduser admin sudo
#USER admin

ENTRYPOINT [ "/bin/bash", "/scanner/nmapAutomator/nmapAutomator.sh" ]
