# command to download demo tls certs for kuard project

for str in crt key; do curl -O https://storage.googleapis.com/kuar-demo/kuard.$str; done
