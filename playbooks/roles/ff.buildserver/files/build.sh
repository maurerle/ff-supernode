#!/bin/bash
# this script copies build products to the relevant place
# call like ./build.sh v2022.1.x experimental
# version can be v2019.1.x v2021.1.x v2022.1.x v2023.1.x next
# branch can be experimental testing stable
version="$1"
branch="$2"

cd ~/site
# builds and signs with build server key
make sign

# deploys build to /var/www/firmware and /var/www/packages
./deploy.sh $version $branch