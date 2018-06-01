output "droplet_IP" {
  value = "${digitalocean_droplet.vpn.ipv4_address}"
}