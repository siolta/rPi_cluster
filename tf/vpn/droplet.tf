resource "digitalocean_droplet" "vpn" {
  image = "${var.image}"
  name = "${var.name}"
  region = "${var.region}"
  size = "${var.size}"
  ssh_keys = ["${var.ssh_key}"]
}
