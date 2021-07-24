#!/usr/bin/env /bin/bash
set -euo pipefail

###
## GLOBAL VARIABLES
###
ZEROTIER_TOKEN=${ZEROTIER_TOKEN:-''}
API_URL_PREFIX=${API_URL_PREFIX:-'https://my.zerotier.com'}
NETWORK_ID=${NETWORK_ID:-''}

curl -s -H "Authorization: Bearer ${ZEROTIER_TOKEN}" -H "Content-Type: application/json" "${API_URL_PREFIX}/api/network/${NETWORK_ID}/member" | jq -r '.[]| "\(.name)***\(.config.id)***\(.config.authorized)***\(.config.ipAssignments[0])"' | column -t -s "***" | sort;
