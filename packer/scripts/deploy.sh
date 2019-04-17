#!/bin/bash

git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
mv /tmp/1 /etc/systemd/system/puma.service
systemctl start puma
systemctl enable puma

