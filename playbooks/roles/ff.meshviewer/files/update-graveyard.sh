#!/bin/bash
# Rebuild graveyard.json in the current directory: nodes that have been offline
# for more than six days, minus the node_ids listed in removelist (a json
# array of nodes that are gone for good and shall never show up).
set -euo pipefail

max_offline=518400 # 6 days in seconds

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

[ -f graveyard.json ] || echo '{"nodes":[]}' > graveyard.json
[ -f removelist ] || echo '[]' > removelist

# a failed download keeps the last graveyard instead of emptying it
wget -qO "$tmp/meshviewer.json" https://map.aachen.freifunk.net/data/meshviewer.json

# merge map and graveyard; per node_id the latest instance wins, so a node
# that came back online drops out of the graveyard
jq -n --slurpfile bl removelist --argjson max "$max_offline" \
	--arg now "$(date +%Y-%m-%dT%H:%M:%S%z)" '
	[inputs | .nodes[]]
	| sort_by(.lastseen) | reverse | unique_by(.node_id)
	| map(select(.is_online == false
		and (.lastseen | strptime("%Y-%m-%dT%H:%M:%S%z") | mktime) < (now - $max)))
	| map(select(.node_id as $id | $bl[0] | index($id) | not))
	| {timestamp: $now, nodes: ., links: []}' \
	"$tmp/meshviewer.json" graveyard.json > "$tmp/graveyard.json"

mv "$tmp/graveyard.json" graveyard.json
