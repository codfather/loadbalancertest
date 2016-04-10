#!/bin/bash

# This runs as root on the server

chef_binary=/usr/bin/chef-solo
tar xvf web-chef-code.tar


# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
   # Upgrade headlessly (this is only safe-ish on vanilla systems)
   apt-get update &&
   #apt-get -o Dpkg::Options::="--force-confnew" \
   #--force-yes -fuy dist-upgrade &&
   # Install Ruby and Chef
   apt-get install -y chef
   #aptitude install -y ruby1.9.1 ruby1.9.1-dev make &&
   #sudo gem1.9.1 install --no-rdoc --no-ri chef --version 0.10.0
fi &&
mv /root/load-balancer.conf /root/chef/cookbooks/op/files/default/
cd chef
"$chef_binary" -c solo.rb -j solo.json
#cd ..
#rm -rf /etc/nginx/sites-enabled/default
#service nginx restart
