#!/bin/bash -e
# https://github.com/nodesource/distributions/blob/master/README.md#debinstall
# Using Debian, as root
wget https://bitcoincore.org/bin/bitcoin-core-22.0/bitcoin-22.0-aarch64-linux-gnu.tar.gz
tar zxvf bitcoin-22.0-aarch64-linux-gnu.tar.gz
install -m 0755 -o nobody -g nogroup -t /usr/local/bin bitcoin-22.0/bin/*

#!/bin/bash -e
  cd files
  cp bitcoind.service "${ROOTFS_DIR}/etc/systemd/system/"
  mkdir -p "${ROOTFS_DIR}/etc/bitcoin/"
  cp bitcoin.conf "${ROOTFS_DIR}/etc/bitcoin/"
