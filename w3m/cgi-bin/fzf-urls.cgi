#!/bin/sh
# This script requires:
# - pup: for HTML parsing
# - jq: for JSON parsing
# - fzf: for selection
# It parses an HTML source at /tmp/source.html, lets you fuzzily select a url, and writes the selected URL to /tmp/w3m_target_url

checkdeps() {
  for com in "$@"; do
    command -v "$com" >/dev/null 2>&1 \
      || { printf '%s not found.\n' "$com" >&2 && exit 1; }
  done
}

case "$(file --mime-type /tmp/w3m_source.html -bL)" in
  application/x-gzip) mv /tmp/w3m_source.html /tmp/w3m_source.gzip && gunzip -f -c /tmp/w3m_source.gzip > /tmp/w3m_source.html && rm /tmp/w3m_source.gzip;;
  application/x-bzip2) mv /tmp/w3m_source.html /tmp/w3m_source.bz2 && bunzip2 -f -c /tmp/w3m_source.bz2 > /tmp/w3m_source.html && rm /tmp/w3m_source.bz2;;
esac

</tmp/w3m_source.html pup 'a json{}' \
  | jq -r '.[] | [.text, .href] | @tsv' \
  | fzf  --prompt "Choose a link > " --layout=reverse \
  | cut -f2 > /tmp/w3m_target_url

rm /tmp/w3m_source.html
