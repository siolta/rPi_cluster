## Initial login info:
User: pi
Pass: raspberry

## First steps

# Update sudo password
 sudo passwd root

# Update pi password
 sudo passwd pi

# set hostname
 edit : /etc/hostname
 edit : /etc/hosts

# Enable ssh
 sudo systemctl enable ssh && \
 sudo systemctl start ssh

# Disable avahi and bluetooth
 sudo systemctl stop avahi-daemon
 sudo systemctl disable avahi-daemon
 sudo systemctl disable avahi-daemon.socket
 sudo systemctl stop bluetooth
 sudo systemctl disable bluetooth

# Restart pi
 sudo init 6

# Set config using raspi-config
 - locale en_US.UTF-8
 - tz america / los angeles

# Local config complete, these last steps can be done from ssh

# Update sources
 sudo apt-get update && sudo apt-get upgrade -y

# Install Htop
 sudo apt-get install -y htop

# Update system
 sudo apt dist-upgrade -y 

# Copy ssh key
 ssh-copy-id -i {key_name} {user}@{ip}



 pi_05 : done
 pi_04 : done
 pi_03 : done
 pi_02 : done
 pi_01 : done