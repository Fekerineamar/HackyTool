const axios = require("axios");
const fs = require("fs").promises;
const { URL, URLSearchParams } = require("url");

async function fetchUrlsFromWayback(domain) {
  const waybackUrl = `https://web.archive.org/cdx/search/cdx?url=*.${domain}/*&output=txt&collapse=urlkey&fl=original&page=/`;

  try {
    const response = await axios.get(waybackUrl);
    if (response.status === 200) {
      return response.data.split("\n");
    } else {
      throw new Error(
        `Failed to fetch URLs from Wayback Machine for ${domain}`
      );
    }
  } catch (error) {
    throw new Error(`Error fetching URLs: ${error.message}`);
  }
}

function excludeExtensions(urls, extensionsToExclude) {
  const filteredUrls = new Set();

  for (const url of urls) {
    try {
      const { pathname } = new URL(url);
      const ext = pathname.substr(pathname.lastIndexOf(".")).toLowerCase();
      if (!extensionsToExclude.has(ext)) {
        filteredUrls.add(url);
      }
    } catch (error) {
      console.error(error);
    }
  }

  return Array.from(filteredUrls);
}

function filterUrlsWithParams(urls) {
  return urls.filter((url) => url.includes("?"));
}

function replaceParamsWithPlaceholder(url, placeholder = "FUZZ") {
  try {
    const parsedUrl = new URL(url);
    const queryParams = new URLSearchParams(parsedUrl.search);
    for (const param of queryParams.keys()) {
      queryParams.set(param, placeholder);
    }
    parsedUrl.search = queryParams.toString();
    return parsedUrl.toString();
  } catch (error) {
    console.error(`Invalid URL: ${url}`);
    return url;
  }
}

async function main() {
  const args = process.argv.slice(2);
  const domainIndex = args.indexOf("-d");
  const listIndex = args.indexOf("-l");
  const outputIndex = args.indexOf("-o");
  const placeholderIndex = args.indexOf("-p");

  if (domainIndex === -1 && listIndex === -1) {
    console.log("Please specify either a domain (-d) or a list file (-l).");
    return;
  }

  const domain = domainIndex !== -1 ? args[domainIndex + 1] : "";
  const listFile = listIndex !== -1 ? args[listIndex + 1] : "";
  const outputFileName =
    outputIndex !== -1 ? args[outputIndex + 1] : "output.txt";
  const placeholder =
    placeholderIndex !== -1 ? args[placeholderIndex + 1] : "FUZZ";

  let domains = [];
  if (domain) {
    domains = [domain];
  } else if (listFile) {
    try {
      const data = await fs.readFile(listFile, "utf8");
      domains = data.split("\n").map((line) => line.trim());
    } catch (err) {
      console.error(`Error reading list file: ${err.message}`);
      return;
    }
  }

  const extensionsToExclude = new Set([
    ".jpg",
    ".jpeg",
    ".png",
    ".gif",
    ".pdf",
    ".svg",
    ".json",
    ".css",
    ".js",
    ".webp",
    ".woff",
    ".woff2",
    ".eot",
    ".ttf",
    ".otf",
    ".mp4",
    ".mp3",
    ".txt",
  ]);

  const outputFilePath = outputFileName;
  for (const domain of domains) {
    const urls = await fetchUrlsFromWayback(domain);
    if (urls.length > 0) {
      const cleanedUrls = excludeExtensions(urls, extensionsToExclude);
      const paramUrls = filterUrlsWithParams(cleanedUrls);
      const outputData = paramUrls
        .map((url) => replaceParamsWithPlaceholder(url, placeholder))
        .join("\n");

      try {
        await fs.appendFile(outputFilePath, outputData + "\n");
      } catch (err) {
        console.error(`Error writing to output file: ${err.message}`);
      }
    }
  }

  console.log(`Cleaned URLs with parameters saved to ${outputFilePath}`);
}

main().catch((err) => {
  console.error(`An error occurred: ${err.message}`);
  process.exit(1);
});
