K3S needs cgroups to start the systemd service.
- configure cgroups by appending `cgroup_memory=1 cgroup_enable=memory` to `/boot/firmware/cmdline.txt`
- disable ufw: `ufw disable`

- install main server with `curl -sfL https://get.k3s.io | sh -s - --disable traefik --disable servicelb --write-kubeconfig-mode 644 --tls-san "192.168.1.5" --node-external-ip "192.168.1.5"`
- install followers with `curl -sfL https://get.k3s.io | K3S_URL=https://192.168.1.5:6443 K3S_TOKEN={TOKEN} sh -`


# TODO 
What is the difference between traefik and metallb? :: traefik is ingress, metallb is a load balancer implementation
Can Argo be installed and setup before external-dns and metal-lb?
Configure sync waves for the ArgoCD applications so that they apply in the right order post bootstrap
In the future, research using [Yoke](https://yokecd.github.io/docs/)
Install the Istio sample app: https://istio.io/latest/docs/ambient/getting-started/deploy-sample-app/
Install Grafana (dashboards), Grafana loki (for logs) and prometheus (metrics)
Install cert-manager and configure it for lets-encrypt
Install a PV // storage manager

# New pi 5 update and setup steps
- flash nvme
- update system : sudo apt update && sudo apt full-upgrade
- install packages: btop, raspi-config

# Post k3s install steps
- Create external dns secret (see external dns manifests)
- Apply metal-lb manifests
- Install ArgoCD from kustomize manifests
  - Patch ArgoCD service with hostname and type loadbalancer: `kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'`
  - Patch ArgoCD configMap to allow helm installations
  - Reset ArgoCD admin password: `kubectl get secret -n argocd argocd-initial-admin-secret --template={{.data.password}} | base64 --decode | pbcopy`
- Apply root application
