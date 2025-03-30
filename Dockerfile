FROM ubuntu:latest

WORKDIR /root

RUN apt update -y && apt-get upgrade -y
RUN apt-get install -y \
    git \
    wget \
    curl \
    nmap \
    ffuf \
    ldap-utils \
    snmp \
    bind9-host \
    iputils-ping && \
    nmap --script-updatedb

RUN rm -rf /root/nmapAutomator/*
RUN git clone https://github.com/security-companion/nmapAutomator.git && \
    ln -s /root/nmapAutomator/nmapAutomator.sh /usr/local/bin/

# Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/bin/bash", "/root/nmapAutomator/nmapAutomator.sh" ]
