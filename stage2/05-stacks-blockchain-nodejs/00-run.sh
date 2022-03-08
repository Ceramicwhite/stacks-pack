#!/bin/bash -e
# https://github.com/nodesource/distributions/blob/master/README.md#debinstall
# Using Debian, as root
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs
