#!/bin/sh
uri="$QUERY_STRING"
referer="$HTTP_REFERER"

[ -z "$uri" ] && printf "Error: No URI\n" >&2 && exit 1

open "$uri"

[ -n "$referer" ] && printf "HTTP/1.1 303 See Other\nLocation %s\n" "$referer"
