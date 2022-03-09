#!/bin/bash -e
  cd files
  cp stacks-node.service "${ROOTFS_DIR}/etc/systemd/system/"
  mkdir -p "${ROOTFS_DIR}/etc/stacks-blockchain/"
  cp mainnet-conf.toml "${ROOTFS_DIR}/etc/stacks-blockchain/"
  cp bashrc "${ROOTFS_DIR}/home/stacks/"
  #mv "${ROOTFS_DIR}/home/stacks/bashrc" "${ROOTFS_DIR}/home/stacks/.bashrc"
  mkdir -p bin
  cd bin
  wget https://github.com/stacks-network/stacks-blockchain/releases/download/2.05.0.1.0/linux-arm64.zip
  unzip linux-arm64.zip
  rm linux-arm64.zip
  install -m 0755 -o root -g root -t "${ROOTFS_DIR}/usr/local/bin/" *
