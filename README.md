# nmapAutomatorNG

A script you can run in the background, based on the original project from [21y4d](https://github.com/21y4d/nmapAutomator). So thanks to 21y4d and all the other contributors without whom this would not have been possible.
Compared to the original one this script does some additional checks and provides a docker image.
  
![nmapAutomator](https://i.imgur.com/3cMJIPr.gif)
  
## Summary

The main goal for this script is to automate the process of enumeration & recon that is run every time, and instead focus our attention on real pentesting.  
  
This will ensure two things:  
1. Automate nmap scans. 
2. Always have some recon running in the background. 

Once initial ports are found '*in 5-10 seconds*', we can start manually looking into those ports, and let the rest run in the background with no interaction from our side whatsoever.  

## Disclaimer

Only scan targets for which you have permission to scan. No liability is taken for any damages by using this tool.

## Features

### Scans
1. **Network** : Shows all live hosts in the host's network (~15 seconds)
2. **Port**    : Shows all open ports (~15 seconds)
3. **Script**  : Runs a script scan on found ports (~5 minutes)
4. **Full**    : Runs a full range port scan, then runs a thorough scan on new ports (~5-10 minutes)
5. **UDP**     : Runs a UDP scan "requires sudo" (~5 minutes)
6. **Vulns**   : Runs CVE scan and nmap Vulns scan on all found ports (~5-15 minutes)
7. **Recon**   : Suggests recon commands, then prompts to automatically run them
8. **All**     : Runs all the scans (~20-30 minutes)

*Note: This is a reconnaissance tool, and it does not perform any exploitation.*

### Automatic Recon
With the `recon` option, nmapAutomatorNG will automatically recommend and run the best recon tools for each found port.  
If a recommended tool is missing from your machine, nmapAutomatorNG will suggest how to install it.

### Runs on any shell
nmapAutomatorNG is 100% POSIX compatible, so it can run on any `sh` shell, and on any unix-based machine (*even a 10 YO router!*), which makes nmapAutomatorNG ideal for lateral movement recon.

If you want to run nmapAutomatorNG on a remote machine, simply download a static nmap binary from [this link](https://github.com/andrew-d/static-binaries/raw/master/binaries/linux/x86_64/nmap), or with [static-get](https://github.com/minos-org/minos-static), and transfer it to the remote machine. You can then use `-s/--static-nmap` to specify the path to the static nmap binary.

### Remote Mode (Beta)
With the `-r/--remote` flag nmapAutomatorNG will run in Remote Mode, which is designed to run using POSIX shell commands only, without relying on any external tools.  
Remote Mode is still under development. Only following scans currently work with `-r`:
- [x] Network Scan (currently ping only)
- [ ] Port Scan
- [ ] Full Scan
- [ ] UDP Scan
- [ ] Recon Scan

### Output
nmapAutomatorNG saves the output of each type of scan is saved into a separate file, under the output directory.  
The entire script output is also saved, which you can view with `less -r outputDir/nmapAutomatorNG_host_type.txt`, or you can simply `cat` it.

-----
  
## Requirements:
[gowitness ](https://github.com/sensepost/gowitness), which we can install with:
```bash
sudo apt update
sudo apt install gowitness  -y
```

[sslyze](https://github.com/nabla-c0d3/sslyze), which we can install with:
```bash
sudo apt update
sudo apt install sslyze -y
```

[nuclei](https://github.com/projectdiscovery/nuclei), which we can install with:
```bash
sudo apt update
sudo apt install nuclei -y
```

[ssh-audit](https://github.com/jtesta/ssh-audit), which we can install with:
```bash
sudo apt update
sudo apt install ssh-audit -y
```

[ffuf](https://github.com/ffuf/ffuf), which we can install with:
```bash
sudo apt update
sudo apt install ffuf -y
```

Or [Gobuster](https://github.com/OJ/gobuster) '*v3.0 or higher*', which we can install with:  
```bash
sudo apt update
sudo apt install gobuster -y
```

Other recon tools used within the script include:
|[nmap Vulners](https://github.com/vulnersCom/nmap-vulners)|[sslscan](https://github.com/rbsec/sslscan)|[nikto](https://github.com/sullo/nikto)|[joomscan](https://github.com/rezasp/joomscan)|[wpscan](https://github.com/wpscanteam/wpscan)|
|:-:|:-:|:-:|:-:|:-:|
|[droopescan](https://github.com/droope/droopescan)|[smbmap](https://github.com/ShawnDEvans/smbmap)|[enum4linux](https://github.com/portcullislabs/enum4linux)|[dnsrecon](https://github.com/darkoperator/dnsrecon)|[odat](https://github.com/quentinhardy/odat)|
|[smtp-user-enum](https://github.com/pentestmonkey/smtp-user-enum)|snmp-check|snmpwalk|ldapsearch||

  
Most of these should be installed by default in [Parrot OS](https://www.parrotsec.org) and [Kali Linux](https://www.kali.org).  
*If any recon recommended tools are found to be missing, they will be automatically omitted, and the user will be notified.*
  
## Installation:
```bash
git clone https://github.com/21y4d/nmapAutomatorNG.git
sudo ln -s $(pwd)/nmapAutomatorNG/nmapAutomatorNG.sh /usr/local/bin/
```

-----

## Usage:
```
./nmapAutomatorNG.sh -h
Usage: nmapAutomatorNG.sh -H/--host <TARGET-IP> -t/--type <TYPE>
Optional: [-r/--remote <REMOTE MODE>] [-d/--dns <DNS SERVER>] [-o/--output <OUTPUT DIRECTORY>] [-s/--static-nmap <STATIC NMAP PATH>]

Scan Types:
	Network : Shows all live hosts in the host's network (~15 seconds)
	Port    : Shows all open ports (~15 seconds)
	Script  : Runs a script scan on found ports (~5 minutes)
	Full    : Runs a full range port scan, then runs a thorough scan on new ports (~5-10 minutes)
	UDP     : Runs a UDP scan "requires sudo" (~5 minutes)
	Vulns   : Runs CVE scan and nmap Vulns scan on all found ports (~5-15 minutes)
	Recon   : Suggests recon commands, then prompts to automatically run them
	All     : Runs all the scans (~20-30 minutes)
```

**Example scans**:
```
./nmapAutomatorNG.sh --host 10.1.1.1 --type All
./nmapAutomatorNG.sh -H 10.1.1.1 -t Basic
./nmapAutomatorNG.sh -H academy.htb -t Recon -d 1.1.1.1
./nmapAutomatorNG.sh -H 10.10.10.10 -t network -s ./nmap
```

------

## Download image from docker hub

Regularly the current docker image is uploaded to docker hub. You can download it onto your machine and run it without the need of manually installing tools in eg. a kali VM.
```
docker pull securitycompanion/nmapautomatorng
docker run --privileged -t securitycompanion/nmapautomatorng -a -H scanme.nmap.org -t Full
```
Then you can access the scan results eg. with Docker Desktop or through copying the result files onto your host machine (see below)
------

## Build docker image on your own
First build the container, then run scan and lastly copy results from container onto your host machine (replace CONTAINERNAME with the correct one found with docker ps)
Make sure to delete old containers, images and builds before building a new one
```
docker build --no-cache -t na .
docker run -t na -a -H scanme.nmap.org -t All
docker ps
docker cp CONTAINERNAME:scanner scanner
```

If you want to just start the container and interact with it remove the second part from the ENTRYPOINT in Dockerfile and run
```
docker build -t na .
docker container run -it na
```
------

## Upcoming Features
- [x] Support URL/DNS - Thanks @KatsuragiCSL
- [x] Add extensions fuzzing for http recon
- [x] Add an nmap progress bar
- [x] List missing tools in recon
- [x] Add option to change output folder
- [x] Save full script output to a file
- [x] Improve performance and efficiency of the script - Thanks @caribpa
- [x] Make nmapAutomater 100% POSIX compatible. - Massive Thanks to @caribpa
- [x] Add network scanning type, so nmapAutomatorNG can discover live hosts on the network.
- [ ] Enable usage of multiple scan types in one scan.
- [ ] Enable scanning of multiple hosts in one scan.
- [ ] Fully implement Remote Mode on all scans


**Feel free to send your pull requests :)**  
*For any pull requests, please try to follow these [Contributing Guidelines](CONTRIBUTING.md).*
