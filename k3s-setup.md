K3S needs cgroups to start the systemd service.
- configure cgroups by appending `cgroup_memory=1 cgroup_enable=memory` to `/boot/firmware/cmdline.txt`
- disable ufw: `ufw disable`

- install main server with `curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644`
- install followers with `curl -sfL https://get.k3s.io | K3S_URL=https://192.168.1.5:6443 K3S_TOKEN={TOKEN} sh - --write-kubeconfig-mode 644`


# TODO 
install with an ingress that is not traefik?
What is the difference between traefik and metallb? :: traefik is ingress, metallb is a load balancer implementation


# New pi 5 update and setup steps
- flash nvme
- update system : sudo apt update && sudo apt full-upgrade
- install packages: btop, raspi-config
