# Build on a small alpine image
FROM alpine:latest

# Update all packages and install some packages
RUN apk update && apk upgrade && apk add iptables dnsmasq bash wireguard-tools

# The environment variables describing the hardware and addresses to be bridged
ENV link eth0
ENV wanlink wlan0
ENV host 10.20.30.1/24
ENV client 10.20.30.2

# The environment variables containing the WireGuard settings
ENV ip 10.0.0.2/24
ENV port 51820
ENV private_key CLIENT_PRIVATE_KEY
ENV server_key SERVER_PUBLIC_KEY
ENV endpoint peer-b.example

# Copy over the WireGuard config template
COPY wg0tun.conf /etc/wireguard/wg0tun.conf

# Copy over the network-sharing script and run it with bash
COPY share.sh .
CMD ["bash", "./share.sh"]
