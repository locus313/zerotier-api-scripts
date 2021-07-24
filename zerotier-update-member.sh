#!/usr/bin/env /bin/bash
set -euo pipefail

###
## GLOBAL VARIABLES
###
ZEROTIER_TOKEN=${ZEROTIER_TOKEN:-''}
API_URL_PREFIX=${API_URL_PREFIX:-'https://my.zerotier.com'}
NETWORK_ID=${NETWORK_ID:-''}
NODE_ID=$1
NODE_NAME=$2



curl -X POST -H "Authorization: Bearer ${ZEROTIER_TOKEN}" -H "Content-Type: application/json" "${API_URL_PREFIX}/api/network/${NETWORK_ID}/member/${NODE_ID}" -d '{"config": {"authorized": true}, "name": "'${NODE_NAME}'"}';
