# go-mmproxy
Docker Image of go-mmproxy

https://github.com/kzemek/go-mmproxy

```
podman build --tag go-mmproxy -f Dockerfile
```

podman unit file
```
# vi .config/containers/systemd/mmproxy.container
# vi: ft=systemd
[Unit]
Description=Container mmproxy
After=local-fs.target

[Container]
ContainerName=mmproxy
Image=ghcr.io/chrismaster/go-mmproxy:latest
PodmanArgs=--cap-add=NET_ADMIN
# Volume=%h/mmproxyCONF/allowed-subnets.txt:/conf/allowed-subnets.txt:Z

Environment=in_port=9010
Environment=out_port=8443
Environment=logs=1

# Pod=mmproxy.pod
AutoUpdate=registry

[Service]
TimeoutStartSec=900
RestartSec=10
Restart=always

[Install]
# Start by default on boot
WantedBy=default.target
# RequiredBy=nginx.service
```
