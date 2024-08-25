# Dead Simple VPN

This repo is based on [DSVPN](https://github.com/jedisct1/dsvpn) aka Dead Simple VPN, designed to address the most common use case for using a VPN:

```text
[client device] ---- (untrusted/restricted network) ---- [vpn server] ---- [the Internet]
```

Features:

* Runs on TCP. Works pretty much everywhere, including on public WiFi where only TCP/443 is open or reliable.
* Uses only modern cryptography, with formally verified implementations.
* Small and constant memory footprint. Doesn't perform any heap memory allocations.
* Small (~25 KB), with an equally small and readable code base. No external dependencies.
* Works out of the box. No lousy documentation to read. No configuration file. No post-configuration. Run a single-line command on the server, a similar one on the client and you're done. No firewall and routing rules to manually mess with.
* Works on Linux (kernel >= 3.17), macOS and OpenBSD, as well as DragonFly BSD, FreeBSD and NetBSD in client and point-to-point modes. Adding support for other operating systems is trivial.
* Doesn't leak between reconnects if the network doesn't change. Blocks IPv6 on the client to prevent IPv6 leaks.

## Installation

This is a dockerized version of dsvpn so the install is a little bit different.

## Secret key

DSVPN uses a shared secret (same key for client and server). Create one below for the docker volume mount, as well as copy it locally to use for all clients. Clients should be installed locally and not through docker.

```sh
dd if=/dev/urandom of=vpn.key count=1 bs=32
```

## Server side

Make sure port 2222 is open on your server

```sh
docker compose up -d
```

## Client side install

Use the same IP address as your server. Make sure you copied the vpn.key from above.

```sh
make

sudo ./dsvpn client vpn.key <server_ip> 2222
```
