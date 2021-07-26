#!/usr/bin/env /bin/bash
#set -euo pipefail

###
## GLOBAL VARIABLES
###
ZEROTIER_TOKEN=${ZEROTIER_TOKEN:-''}
API_URL_PREFIX=${API_URL_PREFIX:-'https://my.zerotier.com'}
NETWORK_ID=${NETWORK_ID:-''}


PS3='[Please enter your choice]: '
options=(
    "list-networks (ln): List zerotier networks"       # 1
    "list-members (lm): List zerotier network members" # 2
    "update-member (um): Update zerotier member"       # 3
    "quit: Exit from this menu"                        # 4
    )

function _switch() {
    _reply="$1"
    _NODE_ID="$2"
    _NODE_NAME="$3"

    case $_reply in
        ""|"ln"|"list-networks"|"1")
            curl -s -H "Authorization: Bearer ${ZEROTIER_TOKEN}" -H "Content-Type: application/json" "${API_URL_PREFIX}/api/network" | jq -r '.[]| "\(.config.name)***\(.id)"' | column -t -s "***";
            ;;
        ""|"lm"|"list-members"|"2")
            curl -s -H "Authorization: Bearer ${ZEROTIER_TOKEN}" -H "Content-Type: application/json" "${API_URL_PREFIX}/api/network/${NETWORK_ID}/member" | jq -r '.[]| "\(.name)***\(.config.id)***\(.config.authorized)***\(.config.ipAssignments[0])"' | column -t -s "***" | sort;
            ;;
        ""|"um"|"update-member"|"3")
            curl -s -X POST -H "Authorization: Bearer ${ZEROTIER_TOKEN}" -H "Content-Type: application/json" "${API_URL_PREFIX}/api/network/${NETWORK_ID}/member/${_NODE_ID}" -d '{"config": {"authorized": true}, "name": "'${_NODE_NAME}'"}';
            exit
            ;;
        ""|"quit"|"4")
            echo "Goodbye!"
            exit
            ;;
        ""|"--help")
            echo "Required enviroment variables:"
            echo "ZEROTIER_TOKEN - set with your zerotier api token"
            echo "NETWORK_ID - set with your network id"
            echo "Available commands:"
            printf '%s\n' "${options[@]}"
            ;;
        *) echo "invalid option, use --help option for the commands list";;
    esac
}

while true
do
    # run option directly if specified in argument
    [ ! -z $1 ] && _switch $@ # old method: "${options[$cmdopt-1]}"
    [ ! -z $1 ] && exit 0

    echo "==== ZEROTIER OPTIONS ===="
    select opt in "${options[@]}"
    do
        _switch $REPLY
        break
    done
done
