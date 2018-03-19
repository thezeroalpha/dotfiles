import cfscrape, sys
scraper=cfscrape.create_scraper()
url=sys.argv[1]
cfurl = scraper.get(url).content
name = url.split('/')[-1].replace("$20", "")
with open(name, 'wb') as f: f.write(cfurl)