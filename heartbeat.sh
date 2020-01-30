#!/bin/bash
# A sample Bash script, by redpenguin

while true
do

YOUR_API_NODE="127.0.0.1:3000"
YOUR_WS="127.0.0.1:9944"
YOUR_SLASH_ADDRESS="G7mWyu1Pom5XreLHUzDEcvFp6WaMuLuo4QKxtDB9yJZnH69"

RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

session=$(curl -s "http://$YOUR_API_NODE/api/query/session/currentIndex?websocket=ws://$YOUR_WS" | jq .result)
index=$(curl -s "http://$YOUR_API_NODE/api/query/session/validators?websocket=ws://$YOUR_WS" | jq -r '.[] | to_entries[] | select(.value=="'$YOUR_SLASH_ADDRESS'") | [.key] | @tsv ')
heartbeat=$(curl -s "http://$YOUR_API_NODE/api/query/imOnline/receivedHeartbeats?websocket=ws://$YOUR_WS&session_index=$session&auth_index=$index" | jq .result)
printf "${RED}heartbeat $heartbeat ${CYAN} on session $session ${NC} \n"

sleep 20
done
