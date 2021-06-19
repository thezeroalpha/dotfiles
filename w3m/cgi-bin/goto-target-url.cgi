#!/bin/sh
# Open contents of /tmp/w3m_target_url
printf "%s\r\nw3m-control: DELETE_PREVBUF\r\n" "w3m-control: GOTO $(cat /tmp/w3m_target_url)"
