#!/bin/sh
# Ask for search engine & query, save target URL to /tmp/w3m_target_url
elvi="$(surfraw -elvi | sed '1,/LOCAL/d' | fzf | cut -f1)"
[ -z "$elvi" ] && exit

clear
printf "%s >> Search: " "$elvi"
read -r query
surfraw -p "$elvi" "$query" > /tmp/w3m_target_url
