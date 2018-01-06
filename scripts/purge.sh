#!/bin/bash

# Credits to:
#  - http://vstone.eu/reducing-vagrant-box-size/
#  - https://github.com/mitchellh/vagrant/issues/343

# Notice: Run in `sudo bash`!my

echo "Purging VM (this may take a while)..."

rm -rf ~/.nano
rm -rf ~/.composer/vendor/*
rm -rf ~/.phpstorm_helpers
rm -f ~/.sudo_as_admin_successful

# Remove bash history
unset HISTFILE
rm -f /root/.bash_history /home/vagrant/.bash_history
rm -Rf /home/vagrant/.nano

composer clearcache

apt-get purge -y ri
apt-get purge -y installation-report landscape-common wireless-tools wpasupplicant ubuntu-serverguide
apt-get purge -y python-dbus libnl1 python-smartpm python-twisted-core libiw30
apt-get purge -y python-twisted-bin libdbus-glib-1-2 python-pexpect python-pycurl python-serial python-gobject python-pam python-openssl libffi5

# Remove APT cache
apt-get autoremove -y
apt-get clean -y
apt-get autoclean -y

# Zero free space to aid VM compression
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# Whiteout root
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count;
rm /tmp/whitespace;

# Whiteout /boot
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace;

swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
swapoff $swappart;
dd if=/dev/zero of=$swappart;
mkswap $swappart;
swapon $swappart;
