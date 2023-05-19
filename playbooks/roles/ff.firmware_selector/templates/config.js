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
  enabled_device_categories: ["recommended", "small_kernel_part", "ath10k_lowmem", "8_32", "4_32", "16_32", "broken"],
  // Display a checkbox that allows to display not recommended devices.
  // This only make sense if enabled_device_categories also contains not
  // recommended devices.
  recommended_toggle: {{ recommended_toggle }},
  // Optional link to an info page about no longer recommended devices
  recommended_info_link: '{{ recommended_info_link }}',
  // community prefix of the firmware images
  community_prefix: '{{ community_prefix }}',
  // firmware version regex
  version_regex: {{ version_regex }},
  // relative image paths and branch

  directories: {
    '/firmware/download/from-2022.1.x/factory/': 'v2022.1',
    '/firmware/download/from-2022.1.x/other/': 'v2022.1',
    '/firmware/download/from-2022.1.x/sysupgrade/': 'v2022.1',

    '/firmware/download/from-2021.1.x/factory/': 'v2021.1',
    '/firmware/download/from-2021.1.x/other/': 'v2021.1',
    '/firmware/download/from-2021.1.x/sysupgrade/': 'v2021.1',

    '/firmware/download/from-2019.1.x/factory/': 'v2019.1',
    '/firmware/download/from-2019.1.x/other/': 'v2019.1',
    '/firmware/download/from-2019.1.x/sysupgrade/': 'v2019.1',

    '/firmware/download/from-2023.1.x/factory/': 'v2023.1',
    '/firmware/download/from-2023.1.x/other/': 'v2023.1',
    '/firmware/download/from-2023.1.x/sysupgrade/': 'v2023.1',

    '/firmware/download/from-2023.2.x/factory/': 'v2023.2',
    '/firmware/download/from-2023.2.x/other/': 'v2023.2',
    '/firmware/download/from-2023.2.x/sysupgrade/': 'v2023.2',

  },
  // page title
  title: 'Firmware',
  // branch descriptions shown during selection
  branch_descriptions: {
    'v2022.1': 'Images auf Gluon 2022/Openwrt 22.03 Basis - nicht für 4/32er Geräte',
    'v2021.1': 'Images auf Gluon 2021/Openwrt 19.07 Basis - für 4/32er Geräte',
    'v2023.1': 'Images vom Gluon master (23.03), kein tag-definierter Stand',
    'v2023.2': 'ACHTUNG! - Images von Gluon und OpenWRT master - zukünftige Basis für v2023.2',
    'v2019.1': 'Alte 2019er Images mit FastD'
  },
  // recommended branch will be marked during selection
  recommended_branch: 'v2022.1',
  // experimental branches (show a warning for these branches)
  experimental_branches: ['v2023.1', 'v2023.2'],
  // path to preview pictures directory
  preview_pictures: 'pictures/',
  // link to changelog
  changelog: '{{ firmware_changelog }}'
};
