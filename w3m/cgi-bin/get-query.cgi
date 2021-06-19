#!/bin/sh
# Ask for a string and save to /tmp/w3m_query
printf "Query: "
read -r query
printf "%s" "$query" > /tmp/w3m_query
