#!/usr/bin/env bash

set -e

CLIENT_IP=$1
DESCRIPTION=$2

WG_CONF=/etc/wireguard/wg0.conf

if [ -z "$CLIENT_IP" ] || [ -z "$DESCRIPTION" ]; then
  echo "Usage: $0 <client-ip> <name>"
  exit 1
fi

# Verify this new IP isn't already in use.
if grep -q "$CLIENT_IP" ./wg0.conf; then
  echo "Error: IP $CLIENT_IP already in use."
  exit 1
fi

if ! command -v wg >/dev/null 2>&1; then
  echo "Could not find 'wg' command."
  exit 1
fi


# Generate a private/public key pair for the client.
wg genkey | tee client-privatekey | wg pubkey > client-publickey

# Add the peer to wg0.conf.  Change `AllowedIPs` to set the IP of the peer.
cat >> "${WG_CONF}" <<END

[Peer]
# ${DESCRIPTION}
PublicKey = $(cat client-publickey)
AllowedIPs = ${CLIENT_IP}/32

END

# Create the client config file.
cat > client.conf <<END
[Interface]
## Local Address : A private IP address for wg0 interface.
Address = ${CLIENT_IP}/32
ListenPort = 51999
DNS = 192.168.0.13

## local client privateky
PrivateKey = $(cat client-privatekey)

[Peer]
# remote server public key
PublicKey = $(cat server-publickey)
Endpoint = vpn.thedreaming.org:51999
AllowedIPs = 0.0.0.0/0
END
rm client-publickey client-privatekey

systemctl restart wg-quick@wg0

echo ""
if ! command -v qrencode >/dev/null 2>&1; then
  echo "Error: qrencode command not installed."
  echo "To display qrcode, run:"
  echo ""
  echo "    apt install -y qrencode"
  echo "    qrencode -t ansiutf8 -r client.conf"
else

  qrencode -t ansiutf8 -r client.conf

  echo ""
  echo "Client config written to client.conf."
  echo "Use the QR code above to configure mobile clients."
fi
echo ""
