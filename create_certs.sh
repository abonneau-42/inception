#!/bin/bash

DOMAIN=abonneau.42.fr
SSL_DIR="secrets/certs"

# Create the nginx directory if it doesn't exist
mkdir -p "$SSL_DIR"

# Paths for key and certificate
KEY_PATH="$SSL_DIR/server.key"
CRT_PATH="$SSL_DIR/server.crt"

# Generate self-signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$KEY_PATH" \
    -out "$CRT_PATH" \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=$DOMAIN"

echo "Self-signed SSL certificate generated:"
echo "  Certificate: $CRT_PATH"
echo "  Private Key: $KEY_PATH"