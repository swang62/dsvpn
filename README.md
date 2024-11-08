# Dead Simple VPN

This repo is based on [DSVPN](https://github.com/jedisct1/dsvpn) aka Dead Simple VPN, designed to be a simple 1-to-1 tunnel using TCP:

```text
[client device] ---- (network) ---- [vpn server] ---- [Internet]
```

## Installation

This method only works on linux based systems. DSVPN uses a shared secret (same key for client and server).

```sh
# First build the binary
make

# Create a new key
dd if=/dev/urandom of=vpn.key count=1 bs=32

# Transfer it locally through base64
base64 < vpn.key

# Local computer
echo 'HK940OkWcFqSmZXnCQ1w6jhQMZm0fZoEhQOOpzJ/l3w=' | base64 --decode > vpn.key
```

## Server setup

Make sure port 2222 is open in your firewall settings. Using a non-standard port makes it a bit more flexible to use.

```sh
# Activate the server-side binary
./dsvpn server vpn.key auto 2222

# Optionally, launch it as a service for always-on
# The binary location is set to /root/dsvpn/dsvpn by default
cp dsvpn.service /etc/systemd/system/
systemctl enable dsvpn.service
systemctl start dsvpn.service

# Check to see if the service is active
systemctl status dsvpn
```

Or as a local service:

```sh
cp dsvpn.service /etc/systemd/system/
systemctl enable dsvpn.service
systemctl start dsvpn.service

#Check to see if it's working
systemctl status dsvpn
```

## Client setup

Make sure you know the server IP address, and copied the vpn.key over to your client.

```sh
# Generate the same binary
make

# Connect to your server in client mode
sudo ./dsvpn client vpn.key <server_ip_address> 2222
```
