# gluon-firmware-selector

The firmware_selector role installs the firmware selector with customized config and devices.js.

The resulting folder `/var/www/gluon-firmware-selector/` must then be served on a webpage like `firmware.your-ff-domain.de`

## Adjustments

New devices were added to the `devices.js` and the `directories` and `version_regex` from the config.js was adjusted.
Those are also good candidates to adjust when using this.

Most crucial things can be edited through the template variables.