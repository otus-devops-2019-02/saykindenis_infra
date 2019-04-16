#!/bin/bash

apt update
apt install -y ruby-full ruby-bundler build-essential
#display installed packages version
echo "Currently installed ruby and bundler versions"
ruby -v
bundler -v
