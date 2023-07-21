#!/bin/bash
# this script copies build products to the relevant place
# call like ./deploy.sh from-2022.1.x experimental
# version can be from-2019.1.x from-2021.1.x from-v2022.1.x from-v2023.1.x from-next
# branch can be experimental testing stable
version="$1"
branches="${2:-experimental beta stable}"

# create folders
mkdir -p /var/www/packages/
mkdir -p /var/www/firmware/download/
mkdir -p /var/www/firmware/images/
if [ -n "$version" ]; then
    echo "installing $version and branch $branch"
else
    echo "You must give a version param"
    exit 1
fi

site="site-${version#*-}"
# copy packages
for file in ~/$site/output/packages/*; do
  version_name="${file##*/}"
done

if [ -n "$version_name" ]; then
    echo "copy packages $version_name"
    cp -r ~/$site/output/packages/$version_name /var/www/packages/$version_name
else
    echo "No packages found for $version_name"
    exit 1
fi
mkdir -p /var/www/firmware/images/$version_name
rsync -a --exclude "*.manifest" ~/$site/output/images/* /var/www/firmware/images/$version_name/

cd ~/manifest
git pull
mkdir -p ~/manifest/$version/
for branch in $branches; do
    echo $branch
    mkdir -p /var/www/firmware/$version/$branch

    # copy manifest to branch
    cp ~/$site/output/images/sysupgrade/$branch.manifest ~/manifest/$version/$branch.manifest
    git add $version/$branch.manifest

    # backup current manifests into upper folder
    rm /var/www/firmware/$version/$branch/sysupgrade
    ln -sf /var/www/firmware/images/$version_name/sysupgrade /var/www/firmware/$version/$branch/sysupgrade
    ln -sf ~/manifest/$version/$branch.manifest /var/www/firmware/$version/$branch/sysupgrade/$branch.manifest
done
git commit -m "update $version $branches to $version_name"
#    git push

# symlink for download directorydownload
rm /var/www/firmware/download/$version
ln -sf /var/www/firmware/images/$version_name /var/www/firmware/download/$version
#rm -r ~/site/output/images
