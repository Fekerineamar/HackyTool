import argparse
import requests
from bs4 import BeautifulSoup
from urllib.parse import urlparse, parse_qs, urlencode, urlunparse
import os

def fetch_urls_from_wayback(domain):
    wayback_url = f"https://web.archive.org/cdx/search/cdx?url=*.{domain}/*&output=txt&collapse=urlkey&fl=original&page=/"
    response = requests.get(wayback_url)
    if response.status_code == 200:
        return response.text.split()
    else:
        print(f"Failed to fetch URLs from Wayback Machine for {domain}")
        return []

def exclude_extensions(urls, extensions_to_exclude):
    filtered_urls = set()
    for url in urls:
        parsed_url = urlparse(url)
        path, ext = os.path.splitext(parsed_url.path)
        if ext.lower() not in extensions_to_exclude:
            filtered_urls.add(url)
    return list(filtered_urls)

def filter_urls_with_params(urls):
    return [url for url in urls if '?' in url]

def replace_params_with_placeholder(url, placeholder="FUZZ"):
    parsed_url = urlparse(url)
    query_params = parse_qs(parsed_url.query, keep_blank_values=True)
    for param in query_params:
        query_params[param] = [placeholder]
    modified_query = urlencode(query_params, doseq=True)
    modified_url = urlunparse(parsed_url._replace(query=modified_query))
    return modified_url

def main():
    parser = argparse.ArgumentParser(description="Fetch and clean URLs from the Wayback Machine")
    parser.add_argument("-d", "--domain", help="Domain name for which to fetch URLs")
    parser.add_argument("-l", "--list", help="File containing a list of domains")
    parser.add_argument("-o", "--output", default="output.txt", help="Output file to save cleaned URLs")
    parser.add_argument("-p", "--placeholder", default="FUZZ", help="Placeholder to replace parameters (default: FUZZ)")
    args = parser.parse_args()

    if not args.domain and not args.list:
        print("Please specify either a domain (-d) or a list file (-l).")
        return

    if args.domain:
        domains = [args.domain]
    else:
        with open(args.list, "r") as list_file:
            domains = [line.strip() for line in list_file]

    extensions_to_exclude = {".jpg", ".jpeg", ".png", ".gif", ".pdf", ".svg", ".json",
                            ".css", ".js", ".webp", ".woff", ".woff2", ".eot", ".ttf", ".otf", ".mp4", ".mp3", ".txt"}

    with open(args.output, "w") as output_file:
        for domain in domains:
            urls = fetch_urls_from_wayback(domain)
            if urls:
                cleaned_urls = exclude_extensions(urls, extensions_to_exclude)
                param_urls = filter_urls_with_params(cleaned_urls)
                for url in param_urls:
                    modified_url = replace_params_with_placeholder(url, args.placeholder)
                    output_file.write(modified_url + "\n")

    print(f"Cleaned URLs with parameters saved to {args.output}")

if __name__ == "__main__":
    main()
