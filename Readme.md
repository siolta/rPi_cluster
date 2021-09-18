### Overview

This is a repo that serves to contain configuration scripts for my homelab.  My homelab consists of 4 raspberry pi 3 b+, and one raspberry pi 4, all running raspbian lite, one ubuntu server, and a Digital Ocean droplet running a VPN for remote management.  

Creds for the VPN server need to be provided as usual in a file under /vpn


### Cloud-init runcmd notes
If you've added some `runcmd` lines to your `cloud-init` config, and the commands don't seem to be executing, here's a few things you should know:

### WTF is going on?

1. `runcmd` only has code to "shellify" your strings or array of strings (i.e: turns them into a shell script)
2. `runcmd` will **only** _write_ a shell script into the file `/var/lib/cloud/instance/scripts/runcmd`
3. `runcmd` is part of the `cloud_config_modules` boot stage
4. You need to `execute` that _runcmd shell script_ using the `scripts-user` module
5. `scripts-user` is part of the `cloud_final_modules` boot stage

### Solution

Here's an example config that **WORKS: (as of `v19.3`)**

```yaml
cloud_config_modules:
  - runcmd

cloud_final_modules:
  - scripts-user

runcmd:
  - [ touch, /tmp/myfile ]
```

You can test this by manually running `cloud-init modules --mode config; cloud-init modules --mode final`.

### TODO's

 - Build out TF files to create digital ocean droplet for VPN server
 - Write script to provision (host data) VPN server
 - Figure out why host keys were being aggressively checked, possibly from the .ssh config file?
 - Autoscale to the cloud with: https://johansiebens.dev/posts/2020/09/scale-out-your-raspberry-pi-nomad-cluster-to-the-cloud/
 - Setup monitoring: https://itnext.io/creating-a-full-monitoring-solution-for-arm-kubernetes-cluster-53b3671186cb

## If scheduler and controller manager are unhealthy
check to see if `--port=0` needs to be removed from the manifests.
see here https://stackoverflow.com/questions/64296491/how-to-resolve-scheduler-and-controller-manager-unhealthy-state-in-kubernetes
### Initialize Kubernetes
`kubeadm init --pod-network-cidr 10.244.0.0/16`


