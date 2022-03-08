```
    ▓▓▓▓▓▓                     ▓▓▓▓▓▓
     ▓▓▓▓▓▓▓                 ▓▓▓▓▓▓▓
       ▓▓▓▓▓▓               ▓▓▓▓▓▓
        ▓▓▓▓▓▓             ▓▓▓▓▓▓
         ▓▓▓▓▓▓▓         ▓▓▓▓▓▓▓
           ▓▓▓▓▓▓       ▓▓▓▓▓▓
            ▓▓▓▓▓▓     ▓▓▓▓▓▓
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
            ▓▓▓▓▓▓     ▓▓▓▓▓▓
           ▓▓▓▓▓▓       ▓▓▓▓▓▓
         ▓▓▓▓▓▓▓         ▓▓▓▓▓▓▓
        ▓▓▓▓▓▓             ▓▓▓▓▓▓
       ▓▓▓▓▓▓               ▓▓▓▓▓▓
      ▓▓▓▓▓▓                 ▓▓▓▓▓▓
```

# StacksPack

A Stacks blockchain miner or follower node for Raspberry Pi and similar.

Instructions for building can be found in [Building](BUILDING.md)

## Getting Started

### TLDR

1. Burn the image with your favorite tool.
1. Insert into your Raspberry Pi 3B or later
1. Follow the setup instructions below
1. Default username: stacks
1. Default password: NewInternet
1. SSH is enabled by default
1. The "lite" image has no desktop, cli only.

### Updates

StacksPack has been updated for the Stacks Xenon network. This include the addition of bitcoind, bitcoin configuration, updated binaries, and updated miner configuration.

### Known Issues

If you have issues burning the zip image, feel free to unzip and burn the image file directly. Ubuntu's Startup Disk Creator works with the img file. So does dd. YMMV.

### Downloads

[StacksPack](https://stackspack.s3-us-west-2.amazonaws.com/image_2020-11-29-StacksPack.zip) ([torrent](https://stackspack.s3-us-west-2.amazonaws.com/image_2020-11-29-StacksPack.zip.torrent)) sha256sum: afedd68bd11a0fdae1837d8eff66250df7ff27c63a4eaa5f8dea9f4808c36d0b

[StacksPack lite](https://stackspack.s3-us-west-2.amazonaws.com/image_2020-11-29-StacksPack-lite.zip)
([torrent](https://stackspack.s3-us-west-2.amazonaws.com/image_2020-11-29-StacksPack-lite.zip.torrent)) sha256sum: 90aca6a71bb780dae08cd1826e3301cd93d15dd0a918334359ee03a565bdbad9

### Setup

**Requirements:**

- 4 GB or larger SD card. 8 GB recommend. If you get a cheap one, you'll regret it later.
- 1 TB or larger HD recommended.
- Wired Ethernet or WiFi with DHCP enabled. Wired connection recommended.

**OS configuration**

1. Log into your StacksPack miner via keyboard or ssh. Default username is 'stacks' and default password is 'NewInternet'

2. Change the default password.

   `passwd`

   Follow the prompts.

3. Set up wifi (optional)

   `sudo raspi-config`

   Follow the prompts.

   - '2. Network Options'
   - N2 Wireless Lan
   - Select your country
   - Enter your SSID (wifi network name)
   - Enter your wifi password
   - Finish

   Reboot and log in with your updated password, from step 2

4. Mount your external drive and make a mining folder. Your drive may already be mounted automagically as a media device for the user, but we want to put it in a deterministic spot for the miner.

   Note that bitcoin mainnet (future) requires approximately 330GB as of this writing. Testnet requires only 32GB, currently. Either way, you'll want bitcoin state on an external HD, NOT your local SD card. You _will_ corrupt your card and make it unusable, if you choose to do so. We recommend minimum 500GB partitions for Bitcoin and Stacks, with the caveat that we have no idea what the Stacks mainnet usage will really be, at this point. The below assumes 1 HD, with two partitions. Adjust as you see fit.

   Note also that depending on your logging level, Stacks testnet logs can be 10s of GBs in size. Future note for log rotation goes here.

   `sudo umount /dev/sda1`

   `sudo mkdir /mnt/stacks`

   `sudo mkdir /mnt/bitcoin`

   Mount the partitions.

   `sudo mount /dev/sda1 /mnt/stacks`

   `sudo mount /dev/sda2 /mnt/bitcoin`

   Kewl.

   Add these to your fstab so that they get mounted at reboot.  Adjust as necessary for your system.

   `echo '/dev/sda1 /mnt/stacks ext4 defaults 0 0' | sudo tee -a /etc/fstab`

   `echo '/dev/sda2 /mnt/bitcoin ext4 defaults 0 0' | sudo tee -a /etc/fstab`

5. Install utilities

   `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash`

   `export NVM_DIR="$HOME/.nvm"`
   `[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm`
   `[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion`

   `nvm install node`

   `npm install -g stacks-gen`

   `sudo apt install jq -y`

**Setting up your miner**

6. Configure your bitcoin node

   `sudo vim /etc/bitcoin/bitcoin.conf`

   The default username and password for bitcoin rpc access is defined in this file. Please change the username and password.

7. Start bitcoind.

   Testnet can take anywhere from 2 - 24 hours to sync, depending on your network. Lets get it started.

   `sudo systemctl enable bitcoind.service`

   `sudo systemctl start bitcoind`

   You can check the progress of your node sync with:

   `bitcoin-cli -rpcport=18332 -rpcuser="<the_username_you_defined_in_bitcoin.conf_step_5>" -rpcpassword="<the_password_you_defined_in_bitcoin.conf_step_5>" getblockchaininfo`

   Look for the "verificationprogress" value. It should be 1 or something like 0.9999

8. Generate a testnet keychain

   `stacks-gen sk --testnet > keychain.json`

9. Add your address to bitcoind.

   `bitcoin-cli -rpcport=18332 -rpcuser="<the username you defined>" -rpcpassword="<this username you defined>" -rpcclienttimeout=7200 importaddress "$(tail -n +2 keychain.json | jq -r '.btc')/g"` 

10. Request testnet bitcoin for our miner.  Go here: [https://en.bitcoin.it/wiki/Testnet#Faucets](https://en.bitcoin.it/wiki/Testnet#Faucets).  Use the "btc" address in your keychain.json file for your faucet requests.

11. Add our private key to the miner config

   `sudo sed -i "s/replace-with-your-private-key/$(tail -n +2 keychain.json | jq -r '.private')/g" /etc/stacks-blockchain/xenon-miner-conf.toml`

12. Test the Stacks miner

   First.. wait. Is your bitcoin verification progress > .99? If so proceed. Otherwise go outside and enjoy the fresh air for a while.

   `sudo /usr/local/bin/stacks-node start --config=/etc/stacks-blockchain/xenon-miner-conf.toml`

   Initially the miner will attempt to connect to your bitcoin node and get updated state. Initialization could take a while, be patient.

   If you see any errors, please report them here: <https://gitlab.com/riot.ai/stackspack/-/issues/new>. If not, `ctrl-c` and we'll continue.

13. Enable our miner to run as a system service

   `sudo systemctl enable stacks-node.service`

14. Start our miner

   `sudo systemctl start stacks-node.service`

15. Congratulations! You're helping to test the stacks testnet! We love you for that.

   To view logs at any time, open a terminal and type `sudo journalctl -u stacks-node`

**More**

- Learn more about the innovative new Proof of Tranfer consensus [here](https://blog.blockstack.org/realizing-web-3-proof-of-transfer-mining-with-bitcoin/).
- Join us in the Stacks discord channel: <https://discord.gg/6PcCMU>
- Contribute to StacksPack: <https://gitlab.com/riot.ai/stackspack>
- Thanks to @psq (<https://github.com/psq/stacks-gen>) and @AbsorbingChaos (<https://github.com/AbsorbingChaos/bks-setup-miner>) for their contributions to this.
