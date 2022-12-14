#!/bin/bash

printf "\033[0;32mStarting Tool update & upgrade & installing go/python!!\033[0m" &&
sleep 3 &&
sudo apt update && sudo apt -y upgrade &&
sudo apt install -y python3 &&
sudo apt install -y python3-pip &&
sudo apt install -y nmap &&
wget https://go.dev/dl/go1.19.4.linux-amd64.tar.gz && 
sudo rm -rf /usr/local/go && 
sudo tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz &&
mkdir -p ~/.go &&
echo "GOPATH=$HOME/.go" >> ~/.bashrc &&
echo "export GOPATH" >> ~/.bashrc &&
echo "PATH=\$PATH:\$GOPATH/bin" >> ~/.bashrc &&
echo "PATH=\$PATH:/usr/local/go/bin" >> ~/.profile &&
source ~/.bashrc &&
source ~/.profile &&
sudo rm go1.19.4.linux-amd64.tar.gz;
printf "\033[0;32mSuccessfully installed!! ** installing Tool! **\033[0m" &&
sleep 3 &&
go install -v github.com/tomnomnom/waybackurls@latest &&
go install -v github.com/OWASP/Amass/v3/...@master &&
go install -v github.com/lukasikic/subzy@latest &&
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest &&
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest &&
go install -v github.com/Emoe/kxss@latest &&
go install -v github.com/tomnomnom/gf@latest &&
go install -v github.com/hahwul/dalfox/v2@latest &&
pip install dirsearch &&
pip install uro && 
pip install arjun &&
git clone https://github.com/1ndianl33t/Gf-Patterns &&
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev &&
git clone https://github.com/devanshbatham/ParamSpider &&
git clone https://github.com/s0md3v/XSStrike.git &&
mkdir ~/.gf &&
mv Gf-Patterns/*.json ~/.gf &&
cd ParamSpider &&
pip3 install -r requirements.txt &&
cd .. &&
printf "\033[0;32mDone :)!! Don't forget To follow me thanks!\033[0m"
sleep 2;
