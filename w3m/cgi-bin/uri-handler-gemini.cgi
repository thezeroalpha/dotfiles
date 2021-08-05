#!/bin/sh
# gemini://gempaper.strangled.net/mirrorlist/
# gemini://simplynews.metalune.xyz
# gemini://geminispace.info/search?tmux

# remove gemini:// header
QUERY_STRING=${QUERY_STRING#gemini://}

testproxy() { curl --connect-timeout 1 -s -I -w '%{http_code}' "$1" | head -n1 | grep 200 > /dev/null; }

if testproxy "https://portal.mozz.us/about"; then
  echo "W3m-control: GOTO https://portal.mozz.us/gemini/$QUERY_STRING"
else
  echo "W3m-control: GOTO https://proxy.vulpes.one/gemini/$QUERY_STRING"
fi
