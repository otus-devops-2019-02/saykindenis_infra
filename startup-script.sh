#!/bin/bash
#ruby install
apt update
apt install -y ruby-full ruby-bundler build-essential

#mongodb install
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
apt install -y mongodb-org
systemctl start mongod
systemctl enable mongod

#app install
cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
