wget https://github.com/projectdiscovery/subfinder/releases/download/v2.6.0/subfinder_2.6.0_linux_386.zip
https://github.com/projectdiscovery/naabu/releases/download/v2.1.6/naabu_2.1.6_linux_amd64.zip
https://github.com/projectdiscovery/katana/releases/download/v1.0.2/katana_1.0.2_linux_386.zip
https://github.com/projectdiscovery/uncover/releases/download/v1.0.5/uncover_1.0.5_linux_386.zip
https://github.com/lc/gau/releases/download/v2.1.2/gau_2.1.2_linux_386.tar.gz -P tmp/ && (unzip -o "tmp/*.zip" -d tmp/ || true) && (tar -xzf tmp/*.tar.gz -C tmp/ || true) && rm tmp/*.zip tmp/README* tmp/LICENSE* && mv tmp/* tool/