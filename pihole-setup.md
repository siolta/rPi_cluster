install docker
https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

add user to docker group:
sudo groupadd docker && sudo usermod -aG docker $USER

copy pi-hole compose template under ~/pihole
change password for pihole

disable systemd resolved port
https://docs.pi-hole.net/docker/tips-and-tricks/#disable-systemd-resolved-port-53
sudo sh -c 'mkdir -p /etc/systemd/resolved.conf.d && printf "[Resolve]\nDNSStubListener=no\n" | tee /etc/systemd/resolved.conf.d/no-stub.conf'
sudo sh -c 'rm -f /etc/resolv.conf && ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf'
systemctl restart systemd-resolved

start docker compose
docker compose up -d


Add lists from:
https://github.com/zachlagden/Pi-hole-Optimized-Blocklists
