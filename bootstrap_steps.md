## Initial login info:
User: pi
Pass: raspberry

## First steps

# Update sudo password
 sudo passwd root

# Update pi password
 sudo passwd pi

# Enable ssh
 sudo systemctl enable ssh && \
 sudo systemctl start ssh

# Disable avahi and bluetooth
 sudo systemctl stop avahi-daemon  && \
 sudo systemctl disable avahi-daemon  && \
 sudo systemctl disable avahi-daemon.socket  && \
 sudo systemctl stop bluetooth  && \
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


# Change docker to use systemd cgroupdriver to fix warning when using cgroupfs
# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
    ]
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Restart docker.
systemctl daemon-reload && \
systemctl restart docker

# Add sysctl script to fix docker being way to security conscious
cat <<EOF >/etc/systemd/system/kubelet.service.d/20-local.conf
[Unit]
Requires=docker.service
After=docker.service
[Service]
ExecStartPre=/sbin/iptables -P FORWARD ACCEPT
EOF

# kubeadmn steps:

Note: you can do a `kubeadm reset` to reset the master node and generate a new token
then issue `systemctl daemon-reload && systemctl restart kubelet`

To start using the cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

## CNI networks
Flannel: kubectl apply -f https://rawgit.com/coreos/flannel/master/Documentation/kube-flannel.yml

Weave: kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"


Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.1.187:6443 --token jl53km...i1nr1 \
    --discovery-token-ca-cert-hash sha256:6f7733...10850ef


# K8's CNI config steps

iptables needs to have the forwarding policy set to ACCEPT


# Cluster test first pod

kubectl run hypriot --image=hypriot/rpi-busybox-httpd --replicas=3 --port=80
kubectl expose deployment hypriot --port 80
kubectl get endpoints hypriot

## add cleanup script (flannel specific):
kubeadm reset
systemctl stop kubelet & systemctl stop docker & \
rm -rf /var/lib/cni/ && rm -rf /var/lib/kubelet/* && rm -rf /etc/cni/ & \
ifconfig cni0 down & ip link delete cni0 & \
ifconfig docker0 down & \
ifconfig flannel.1 down & ip link delete flannel.1

# Note on the noctua fans:
Pro-tip:

Optionally, instead of using the supplied Scotchlocks or cutting and soldering/heatshrinking to get the wiring you want, you can pull the three pins out of the connector (push on them from the side with a paperclip or something to depress the little tabs), cut out the yellow wire (I chose to fold it back over the heat-shrink then shrink a new piece on top of it, sandwiching it in place), then put the black and red wires back in--this time in positions where they'll hit the pins you want.

I used pins 2 and 3, but 1 and 3 would work the same and would be possible with this connector.

Ideally, you'd shorten the cable and crimp new female pins in place, then push them into the connector, but leaving it long worked just fine in my situation.
