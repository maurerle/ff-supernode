/*
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

var config = {
  // list images on console that match no model
  listMissingImages: false,
  // see devices.js for different vendor model maps
  vendormodels: vendormodels,
  // set enabled categories of devices (see devices.js)
  enabled_device_categories: ["recommended", "small_kernel_part", "ath10k_lowmem", "8_32", "4_32", "16_32"],
  // Display a checkbox that allows to display not recommended devices.
  // This only make sense if enabled_device_categories also contains not
  // recommended devices.
  recommended_toggle: true,
  // Optional link to an info page about no longer recommended devices
  recommended_info_link: null,
  // community prefix of the firmware images
  community_prefix: 'gluon-ffac-',
  // firmware version regex
  version_regex: /-(v?\d+\.\d+\.\d+(-\d+)?(-.{8}~exp\d{8})?)-/,
  // relative image paths and branch

  directories: {
    // some demo sources
    '../release_images/from-2022.1.x/experimental/factory/': 'v2022_experimental',
    '../release_images/from-2022.1.x/experimental/other/': 'v2022_experimental',
    '../release_images/from-2022.1.x/experimental/sysupgrade/': 'v2022_experimental',

    '../release_images/from-2021.1.x/experimental/factory/': 'v2021_novpn_experimental',
    '../release_images/from-2021.1.x/experimental/other/': 'v2021_novpn_experimental',
    '../release_images/from-2021.1.x/experimental/sysupgrade/': 'v2021_novpn_experimental',

    //'http://updates.freifunk-aachen.de/stable/factory/': 'oldstable',
    //'http://updates.freifunk-aachen.de/other/': 'oldstable',
    //'http://updates.freifunk-aachen.de/sysupgrade/': 'oldstable',

  },
  // page title
  title: 'Firmware',
  // branch descriptions shown during selection
  branch_descriptions: {
    v2022_experimental: 'Images auf Gluon 2022/Openwrt 2022 Basis mit tag und WG - nicht für 4/32er Geräte',
    v2021_novpn_experimental: 'Images Gluon 2021 ohne Mesh-VPN möglichkeit'
    //v2019: 'Images basierend auf Gluon 2021, OpenWRT 2019 - mit Wireguard'
  },
  // recommended branch will be marked during selection
  recommended_branch: 'v2022-experimental',
  // experimental branches (show a warning for these branches)
  experimental_branches: [''],
  // path to preview pictures directory
  preview_pictures: 'pictures/',
  // link to changelog
  changelog: 'CHANGELOG.html',
  // links for instructions like flashing of certain devices (optional)
  // can be set for a whole model or individual revisions
  // overwrites default values from devices_info in devices.js
  devices_info: {
    'AVM': {
      "FRITZ!Box 4040": "https://fritz-tools.readthedocs.io"
    },
    "TP-Link": {
      "TL-WR841N/ND": {"v13": "https://wiki.freifunk.net/TP-Link_WR841ND/Flash-Anleitung_v13"}
    }
  }
};
