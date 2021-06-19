#!/bin/sh
# Search contents of /tmp/w3m_query with searx
[ -f /tmp/w3m_query ] || exit
q="$(cat /tmp/w3m_query)"
printf "%s\r\nw3m-control: DELETE_PREVBUF\r\n" "w3m-control: GOTO https://search.alex.balgavy.eu/searx/search?q=$q"
