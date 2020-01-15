#!/bin/bash

### stuck alert script by redpenguin
### requires jq installed
### launch with screen
### $ screen -Smd alert bash ./stuck_alert.sh
### to attach
### $ screen -r alert

chat_id="0000000" # your telegram id
apiToken="0000000:xxxxxxxxxxxxxxxxxxxxxxxxx" # yuor bot api token

curl -s -X POST https://api.telegram.org/bot$apiToken/sendMessage -d text="kusama-m monitor started" -d chat_id=$chat_id


while true; do

a=$(curl -s -H 'Content-Type: application/json' -d '{ "jsonrpc": "2.0", "method":"chain_getBlockHash", "params":[], "id": 1 }' http://localhost:9933/ | jq '.result')

sleep 20

b=$(curl -s -H 'Content-Type: application/json' -d '{ "jsonrpc": "2.0", "method":"chain_getBlockHash", "params":[], "id": 1 }' http://localhost:9933/ | jq '.result')

echo $a
echo $b


if [[ "$a" == "$b" ]]
then
echo "uguali"
curl -s -X POST https://api.telegram.org/bot$apiToken/sendMessage -d text="kusama-m is stuck" -d chat_id=$chat_id
else
echo "diversi"
fi

done
