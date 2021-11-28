#!/bin/sh
# Ask for search engine & query, save target URL to /tmp/w3m_target_url
query_url="$(fzf-surfraw)"
[ -n "$query_url" ] || exit
printf '%s' "$query_url" > /tmp/w3m_target_url
