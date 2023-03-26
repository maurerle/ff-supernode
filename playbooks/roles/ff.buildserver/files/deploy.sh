#!/bin/bash
# this script copies build products to the relevant place
# call like ./deploy.sh from-2022.1.x experimental
# version can be from-2019.1.x from-2021.1.x from-v2022.1.x from-v2023.1.x from-next
# branch can be experimental testing stable
version="$1"
branch="$2"

# create folders
mkdir -p /var/www/packages/
mkdir -p /var/www/firmware/download/
if [ -n "$version" ]; then
    echo "installing $version and branch $branch"
else
    echo "You must give a version param"
    exit 1
fi

if [ -n "$branch" ]; then
    mkdir -p /var/www/firmware/$version/$branch
    # copy packages
    cp -r ~/site/output/packages/* /var/www/packages/

    # copy manifest to branch
    cd ~/manifest
    git pull
    mkdir -p ~/manifest/$version/
    cp ~/site/output/images/sysupgrade/$branch.manifest ~/manifest/$version/$branch.manifest
    git add $version/$branch.manifest
    git commit -m "update $version/$branch.manifest"
#    git push

    # backup current manifests into upper folder
    cp /var/www/firmware/$version/$branch/sysupgrade/*.manifest /var/www/firmware/$version/$branch/
    rm -rf /var/www/firmware/$version/$branch/sysupgrade
    # copy sysupgrade for updates
    cp -r ~/site/output/images/sysupgrade /var/www/firmware/$version/$branch/sysupgrade
    # restore manifests from upper folder
    mv /var/www/firmware/$version/$branch/*.manifest /var/www/firmware/$version/$branch/sysupgrade/


    # delete current manifest and recreate as symlink
    rm /var/www/firmware/$version/$branch/sysupgrade/$branch.manifest
    ln -s ~/manifest/$version/$branch.manifest /var/www/firmware/$version/$branch/sysupgrade/$branch.manifest
fi

# copy for firmware selector download
rm -rf /var/www/firmware/download/$version
cp -r ~/site/output/images /var/www/firmware/download/$version
#rm -r ~/site/output/images
