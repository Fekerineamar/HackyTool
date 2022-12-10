#!/bin/bash

Green='\033[0;32m' &&
NC='\033[0m' &&
printf "{Green}Starting Tool!!{NC}" &&
sleep 3 &&
sudo apt update && sudo apt upgrade -y &&
sudo apt install python3 -y &&
sudo apt install nmap -y &&
wget https://go.dev/dl/go1.19.4.linux-amd64.tar.gz && 
sudo rm -rf /usr/local/go && 
sudo tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz &&
mkdir ~/.go &&
echo "GOPATH=$HOME/.go" >> ~/.bashrc &&
echo "export GOPATH" >> ~/.bashrc &&
echo "PATH=\$PATH:\$GOPATH/bin # Add GOPATH/bin to PATH for scripting" >> ~/.bashrc source ~/.bashrc &&
sudo rm go1.19.4.linux-amd64.tar.gz &&
go install -v github.com/tomnomnom/waybackurls@latest &&
go install -v github.com/OWASP/Amass/v3/...@master &&
go install -v github.com/lukasikic/subzy@latest &&
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest &&
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest &&
go install -v github.com/Emoe/kxss@latest &&
go install -v github.com/tomnomnom/gf@latest &&
pip install dirsearch &&
pip install uro && 
pip install arjun &&
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev &&
git clone https://github.com/devanshbatham/ParamSpider &&
cd ParamSpider &&
pip3 install -r requirements.txt &&
echo "{GREEN}Done :)!! Don't forget To follow me thanks!{NC}"
sleep 2
