#!/bin/bash

git clone https://github.com/belzebub40k/router-pics.git
git clone https://github.com/Moorviper/Freifunk-Router-Anleitungen
git clone https://github.com/nalxnet/freifunk-device-images
git clone https://github.com/freifunkstuff/meshviewer-hwimages

mkdir -p output-folder
cp router-pics/*.svg output-folder/
cp freifunk-device-images/*.svg output-folder/
cp meshviewer-hwimages/hwimg/*.svg output-folder/
for file in Freifunk-Router-Anleitungen/router/**/front.svg; do
    cutfront=${file##Freifunk-Router-Anleitungen/router/}
    routername=${cutfront%%/front.svg} 
    cp $file output-folder/$routername.svg
done;



for file in output-folder/*.svg; do
    normalized=${file##output-folder/}
    normalized=${normalized%.svg}
    normalized="output-folder/$(echo $normalized | sed -e 's/fritzbox/fritz-box/ig' -e 's/[^a-z0-9\-]/-/ig')"
    echo $normalized.svg
    mv $file $normalized.svg
    #inkscape $normalized.svg  --batch-process --export-type=png --export-filename="$normalized.png"
    #inkscape $normalized.svg  --batch-process --export-type=jpg --export-filename="$normalized.jpg"
done;

cd output-folder
ln -sf 8devices-jalapeno-board.svg 8devices-jalapeno.svg
ln -sf avm-fritz-wlan-repeater-450e.svg avm-fritz-wlan-repeater-300e.svg
ln -sf avm-fritz-box-7360.svg avm-fritz-box-7430.svg
ln -sf avm-fritz-box-7530.svg avm-fritz-box-7520.svg
ln -sf devolo-wifi-pro-1200i.svg devolo-wifi-pro-1750i.svg
ln -sf d-link-dap-x1860-a1.svg d-link-dap-x1860.svg
ln -sf gl-inet-gl-ar150.svg gl.inet-gl-ar150.svg
ln -sf gl-inet-gl-ar300m.svg gl.inet-gl-ar300m-lite.svg
ln -sf gl-inet-gl-ar300m.svg gl.inet-gl-ar300m.svg
ln -sf gl-inet-gl-ar750.svg gl.inet-gl-ar750.svg
ln -sf gl-inet-gl-ar750s.svg gl.inet-gl-ar750s-nor.svg
ln -sf gl-inet-gl-ar750s.svg gl.inet-gl-ar750s.svg
ln -sf gl-inet-gl-mt750.svg gl-mt750.svg
ln -sf gl-inet-gl-b1300.svg gl.inet-gl-b1300.svg
ln -sf gl-inet-vixmini.svg gl.inet-vixmini.svg
ln -sf gl-inet-gl-mt300a.svg gl-mt300a.svg
ln -sf gl-inet-gl-mt300n.svg gl-mt300n.svg
ln -sf gl-inet-microuter-n300.svg gl.inet-microuter-n300.svg
ln -sf netgear-ex6150v2.svg netgear-ex6100.svg
ln -sf netgear-ex6150v2.svg netgear-ex6150.svg
ln -sf netgear-ex6150v2.svg netgear-ex6150-v2.svg
ln -sf netgear-dgn3500.svg netgear-dgn3500b.svg
ln -sf nexx-wt3020.svg nexx-wt3020ad.svg
ln -sf nexx-wt3020.svg nexx-wt3020f.svg
ln -sf nexx-wt3020.svg nexx-wt3020h.svg
ln -sf ocedo-indoor.svg ocedo-koala.svg
ln -sf ocedo-koala.svg ocedo-raccoon.svg
ln -sf openmesh-a40.svg openmesh-a42.svg
ln -sf openmesh-a40.svg openmesh-a60.svg
ln -sf openmesh-a40.svg openmesh-a62.svg
ln -sf openmesh-mr900-v2.svg openmesh-mr1750.svg
ln -sf openmesh-om2p-hs.svg openmesh-om2p-lc.svg
ln -sf openmesh-om2p-hs.svg openmesh-om5p-an.svg
ln -sf openmesh-om2p-hs.svg openmesh-om5p.svg
ln -sf raspberry-pi-model-b.svg raspberrypi-model-b.svg
ln -sf raspberry-pi-v2-model-b.svg raspberrypi-2-model-b.svg
ln -sf raspberry-pi-v3-model-b.svg raspberrypi-3-model-b.svg
ln -sf raspberry-pi-model-b.svg raspberry-pi.svg
ln -sf tp-link-archer-c7-v2.svg tp-link-archer-c59-v1.svg
ln -sf tp-link-archer-c7-v2.svg tp-link-archer-c7-v4.svg
ln -sf tp-link-archer-c7-v2.svg tp-link-archer-c7-v5.svg
ln -sf tp-link-archer-c20i.svg tp-link-archer-c20i-alle.svg
ln -sf tp-link-cpe210-v1.svg tp-link-cpe210-v2.svg
ln -sf tp-link-cpe210-v1.svg tp-link-cpe210-v3.svg
ln -sf tp-link-cpe210-v1.svg tp-link-cpe220-v1.svg
ln -sf tp-link-cpe210-v1.svg tp-link-cpe220-v3.svg
ln -sf tp-link-cpe210-v1.svg tp-link-cpe510-v1.svg
ln -sf tp-link-cpe210-v1.svg tp-link-cpe510-v3.svg
ln -sf tp-link-tl-wdr3600-v1.svg tp-link-td-w8970-alle.svg
ln -sf tp-link-tl-wdr4300-v1.svg tp-link-tl-wdr4900-v1.svg
ln -sf tp-link-archer-c7-v2.svg tp-link-td-w8980-alle.svg
ln -sf tp-link-archer-c7-v2.svg tp-link-td-w9980-alle.svg
ln -sf tp-link-tl-mr3020-v1.svg tp-link-tl-mr3020-v3.svg
ln -sf tp-link-tl-mr3420-v2.svg tp-link-tl-mr3420-v5.svg
ln -sf tp-link-tl-wa801n-nd-v1.svg tp-link-tl-wa801nd-v5.svg
ln -sf tp-link-tl-wr1043n-nd-v4.svg tp-link-tl-wr1043n-v5.svg
ln -sf tp-link-tl-wr841n-nd-v12.svg tp-link-tl-wr841n-v13.svg
ln -sf tp-link-tl-mr3020-v1.svg tp-link-tl-wr902ac-v3.svg
ln -sf tp-link-wbs210-v1.20.svg tp-link-wbs510-v1.20.svg
ln -sf ubiquiti-unifi-ac-lite.svg ubiquiti-unifi-ac-lite-mesh.svg
ln -sf ubiquiti-unifi-ac-pro.svg ubiquiti-unifi-ap-pro.svg
ln -sf vocore-v2.svg vocore2.svg
ln -sf xiaomi-mi-router-4a-gigabit-edition.svg xiaomi-mi-router-4a-100m-edition.svg
ln -sf xiaomi-mi-router-4a-gigabit-edition.svg xiaomi-mi-router-4a-100m-international-edition.svg
ln -sf xiaomi-mi-router-4c.svg xiaomi-mi-router-3g.svg

wget -O no_picture_available.jpg https://raw.githubusercontent.com/freifunk-darmstadt/gluon-firmware-selector/master/pictures/no_picture_available.jpg
wget -O x86-generic.img.svg https://raw.githubusercontent.com/freifunk-darmstadt/gluon-firmware-selector/master/pictures/x86-generic.img.jpg
wget -O x86-kvm.img.svg https://raw.githubusercontent.com/freifunk-darmstadt/gluon-firmware-selector/master/pictures/x86-kvm.img.jpg
wget -O x86-legacy.img.svg https://raw.githubusercontent.com/freifunk-darmstadt/gluon-firmware-selector/master/pictures/x86-legacy.img.jpg
wget -O x86-virtualbox.vdi.svg https://raw.githubusercontent.com/freifunk-darmstadt/gluon-firmware-selector/master/pictures/x86-virtualbox.vdi.jpg
wget -O x86-vmware.vmdk.svg https://raw.githubusercontent.com/freifunk-darmstadt/gluon-firmware-selector/master/pictures/x86-vmware.vmdk.jpg
cd ..

# app.js must look for .svg images
rm -rf pictures
mv output-folder pictures