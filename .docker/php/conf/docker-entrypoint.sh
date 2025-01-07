#!/bin/bash
set -e

if [ "$1" = 'frankenphp' ] || [ "$1" = 'php' ] || [ "$1" = 'bin/magento' ]; then
	if [ ! -f /etc/caddy/certs/tls.pem ]; then
		mkdir -p /etc/caddy/certs
		mkcert -install
		mkcert -cert-file /etc/caddy/certs/tls.pem -key-file  /etc/caddy/certs/tls.key "$SERVER_NAME"
	fi
fi

exec docker-php-entrypoint "$@"
