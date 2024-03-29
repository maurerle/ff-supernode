#!/bin/sh
#download meshviewer.json
wget -qO meshviewer.json https://map.aachen.freifunk.net/data/meshviewer.json
#read the nodes-array from current graveyard AND map
jq  '.nodes[]'  meshviewer.json graveyard.json |
#sort all nodes and keep only the latest instance if are there more than one with the same node_id. this makes ressurrected nodes dissappear from the graveyard automatically
jq -s '.|sort_by(.lastseen)|reverse|unique_by(.node_id)' |
#keep only ndoes that are labeled offline and were last seen 518400s (=6 days) ago. adept the number of seconds to your needs
jq  '.[]|select((.is_online==false) and (.lastseen|strptime("%Y-%m-%dT%H:%M:%S%z") |mktime < (now-518400)))' |
#the removelist is a json array containing all the node_ids that shall never appear on the graveyard. for instance if a node is truely dead and will never return to the map
jq --slurpfile bl removelist '.|select(.node_id|inside($bl|tostring)|not)' |
#set the timestamp of runtime and write everything to a temporary file
jq -s --arg mydate $(date +%Y-%m-%dT%H:%M:%S%z) '{timestamp:$mydate,nodes:.,links:[]}' > tmpgraveyard.json
#overwrite the graveyard with the temporary file
mv tmpgraveyard.json graveyard.json
