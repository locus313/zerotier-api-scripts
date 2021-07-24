#!/usr/bin/env /bin/bash
set -euo pipefail

###
## GLOBAL VARIABLES
###
ZEROTIER_TOKEN=${ZEROTIER_TOKEN:-''}
API_URL_PREFIX=${API_URL_PREFIX:-'https://my.zerotier.com'}


curl -s -H "Authorization: Bearer ${ZEROTIER_TOKEN}" -H "Content-Type: application/json" "${API_URL_PREFIX}/api/network" | jq -r '.[]| "\(.config.name)***\(.id)"' | column -t -s "***";
