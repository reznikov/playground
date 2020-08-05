#!/bin/bash

set -x

sed -i "s/raspberrypi/$HOSTNAME/" /etc/hosts
sed -i "s/raspberrypi/$HOSTNAME/" /etc/hostname

useradd \
  --home /home/$USERNAME \
  --create-home $USERNAME \
  --groups adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio

mkdir /home/$USERNAME/.ssh/
touch /home/$USERNAME/.ssh/authorized_keys
chmod 700 /home/$USERNAME/.ssh
chmod 600 /home/$USERNAME/.ssh/authorized_keys
chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

sed "s/pi/$USERNAME/" /etc/sudoers.d/010_pi-nopasswd >> /etc/sudoers.d/010_$USERNAME-nopasswd
chmod 440 /etc/sudoers.d/010_$USERNAME-nopasswd
rm /etc/sudoers.d/010_pi-nopasswd

userdel --remove pi

apt-get update -yqq
apt-get full-upgrade -yqq
apt-get autoremove -yqq
apt-get autoclean -yqq


sed -i "s/exit 0/\/usr\/bin\/tvservice -o\nexit 0/" /etc/rc.local
sed -i "s/dtparam=audio=on/#dtparam=audio=on/" /boot/config.txt
echo "dtoverlay=disable-wifi" >>/boot/config.txt

touch /boot/ssh

sed -i "/PasswordAuthentication/d" /etc/ssh/sshd_config
sed -i "/PermitRootLogin/d" /etc/ssh/sshd_config

{
  echo
  echo "PasswordAuthentication no"
  echo "PermitRootLogin no"
} >>/etc/ssh/sshd_config

rm -rf /var/log/*
rm -rf /tmp/*
