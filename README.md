# Dead Simple VPN

This repo is based on [DSVPN](https://github.com/jedisct1/dsvpn) aka Dead Simple VPN, designed to address the most common use case for using a VPN:

```text
[client device] ---- (untrusted/restricted network) ---- [vpn server] ---- [the Internet]
```

Features:

- Runs on TCP. Works pretty much everywhere, including on public WiFi where only TCP/443 is open or reliable.
- Uses only modern cryptography, with formally verified implementations.
- Small and constant memory footprint. Doesn't perform any heap memory allocations.
- Small (~25 KB), with an equally small and readable code base. No external dependencies.
- Works out of the box. No lousy documentation to read. No configuration file. No post-configuration. Run a single-line command on the server, a similar one on the client and you're done. No firewall and routing rules to manually mess with.
- Works on Linux (kernel >= 3.17), macOS and OpenBSD, as well as DragonFly BSD, FreeBSD and NetBSD in client and point-to-point modes. Adding support for other operating systems is trivial.
- Doesn't leak between reconnects if the network doesn't change. Blocks IPv6 on the client to prevent IPv6 leaks.

## Installation

DSVPN uses a shared secret (same key for client and server). Create one with `dd if=/dev/urandom of=vpn.key count=1 bs=32`

## Server side setup

Make sure port 2222 is open on your server/firewall settings.

Docker version:

```sh
docker compose up -d
```

Or as a local service:

```sh
cp dsvpn.service /etc/systemd/system/
systemctl enable dsvpn.service
systemctl start dsvpn.service

#Check to see if it's working
systemctl status dsvpn
```

## Connect a client (linux/macOS only)

Use the same IP address as your server. Make sure you've copied the vpn.key from above into this directory.

```sh
make

sudo ./dsvpn client vpn.key <server_ip> 2222
```
