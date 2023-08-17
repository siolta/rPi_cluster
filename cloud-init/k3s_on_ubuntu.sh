#!/bin/sh

# install prereqs for k3s
sudo apt install linux-modules-extra-raspi -y

# insert to /etc/cloud/templates/hosts.debian.tmpl
cat >> /etc/cloud/templates/hosts.debian.tmpl <<EOF
# Black Bramble hosts
192.168.1.119 blackbramble0m
192.168.1.113 blackbramble01
192.168.1.148 blackbramble02
192.168.1.140 blackbramble03
192.168.1.147 blackbramble04
192.168.1.131 blackbramble05
EOF

# append to /boot/cmdline.txt
cat >> /boot/cmdline.txt <<EOF
cgroup_memory=1 cgroup_enable=memory
EOF

init 6
