#!/bin/sh
# Read query for Searx, save target URL to /tmp/w3m_target_url
query="$(fzf --print-query --prompt="Searx >> Search: " --info=hidden --layout=reverse </dev/null)"
surfraw -p searx "$query" > /tmp/w3m_target_url
