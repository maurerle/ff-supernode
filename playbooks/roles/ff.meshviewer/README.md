# meshviewer

The meshviewer presents the frontend map which reads the meshviewer.json and nodes.json which is created by a respondd node info collector (like yanic).

The meshviewer allows to have a geo overlay to show the segments/domains of your freifunk site.

Nodes with a deprecated or end-of-life device get a hint; the texts are
`deprecation_text` and `eol_text`, set for this site in `group_vars/all/main.yml`.
Upstream ships the device lists: its `eol` list is the 4 MB/32 MB class and
`deprecated` holds the 8 MB/64 MB repeaters, so the template swaps the two texts
- see the comment in `defaults/main.yml`.

## Install

The role unpacks the `meshviewer-build.zip` artifact of an upstream
[release](https://github.com/freifunk/meshviewer/releases) into
`{{ meshviewer_webroot }}` instead of building a git checkout on the host, so no
node/npm is needed. `meshviewer_version` and `meshviewer_checksum` in
`defaults/main.yml` pin the release; bump both to move to a new version.

The config is rendered from `templates/meshviewer_config.json.j2`; the keys are
documented in the upstream
[CONFIGURATION.md](https://github.com/freifunk/meshviewer/blob/main/CONFIGURATION.md).

Device pictures are converted from
[freifunk/device-pictures](https://github.com/freifunk/device-pictures) into
`/var/www/html/pictures-svg` and referenced via `device_pictures_url`.

## Geo overlay

`meshviewer_geo` is a YAML list of layers (rendered to JSON); each layer takes either a `url` (fetched
by the browser when the map opens) or an inline `json` GeoJSON object, plus an
`option` that is handed to Leaflet's `L.geoJSON`. A feature with a `name`
property gets a tooltip, and a layer that cannot be loaded shows a notice in the
map instead of failing silently.

The segment boundaries live in `files/geo/` and are copied into the webroot, so
nginx can cache them separately from `config.json`. The stored file is rounded
to 4 decimals (~11 m); regenerate it from the source instead of editing
coordinates by hand.

## Client side charts

Meshviewer 14 can query Grafana's HTTP API and draw the charts in the browser:
faster and sharper than the rendered images, and no load on the image renderer.
The map host proxies the one endpoint it uses, `POST /api/ds/query`, under
`/_grafana` (`ff.nginx`, `proxy.conf`), so the requests stay same-origin and
Grafana needs no CORS setting. `meshviewer_grafana_browser_url` points the config there, while a
chart's `href` still opens the absolute `grafana_url` dashboard.

The charts for this site live in `group_vars/all/main.yml`
(`meshviewer_grafana_charts`), next to `grafana_datasource_uid`, the uid
`ff.grafana` provisions the influxdb datasource with; an empty list keeps only the images. The queries
are the InfluxQL of the matching panels of the "Node" dashboard (uid `000000002`)
with `$node` as the placeholder the meshviewer replaces, and `series[].name`
matching the column alias. `negate: true` flips a series, e.g. TX below the axis.

## Graveyard

`/graveyard` serves the same build with nodes that have been offline for more
than six days. A daily cron job of `ffac` runs `/usr/local/bin/update-graveyard.sh`
in `/home/ffac`; node_ids in `/home/ffac/removelist` (a JSON array) never show up.
