#!/bin/sh

# insert to /etc/cloud/templates/hosts.debian.tmpl
cat >> /etc/cloud/templates/hosts.debian.tmpl <<EOF
# Black Bramble hosts
192.168.1.3 blackbramble0m
192.168.1.5 blackbramble01
192.168.1.6 blackbramble02
192.168.1.7 blackbramble03
EOF

# append to /boot/firmware/cmdline.txt
cat >> /boot/firmware/cmdline.txt <<EOF
cgroup_memory=1 cgroup_enable=memory
EOF

init 6
