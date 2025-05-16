# Versions
FROM dunglas/frankenphp:1.5.0-php8.3 AS frankenphp_upstream

# Base FrankenPHP image
FROM frankenphp_upstream AS frankenphp_base

WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
	cron \
    ssmtp \
    libfreetype6-dev \
	libicu-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libxslt1-dev \
	zip \
	git \
    acl \
	&& rm -rf /var/lib/apt/lists/*

RUN set -eux; \
	install-php-extensions \
		@composer \
    	bcmath \
	  	gd \
	  	intl \
	  	mbstring \
	  	mcrypt \
	  	opcache \
	  	pdo_mysql \
	  	soap \
  		xsl \
  		zip \
    	sockets

# Copy the application code
COPY --link ./.docker/php/conf/app.ini $PHP_INI_DIR/conf.d/
COPY --link --chmod=755 ./.docker/php/conf/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
COPY --link ./.docker/php/conf/Caddyfile /etc/caddy/Caddyfile

# Set the entrypoint
ENTRYPOINT ["docker-entrypoint"]

HEALTHCHECK --start-period=60s CMD curl -f https://$SERVER_NAME/health_check.php || exit 1
CMD [ "frankenphp", "run", "--config", "/etc/caddy/Caddyfile" ]

# Development FrankenPHP image
FROM frankenphp_base AS frankenphp_dev

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN apt-get update && apt-get install -y --no-install-recommends mkcert

RUN set -eux; \
	install-php-extensions \
		xdebug

# Configuration for development
COPY --link ./.docker/php/conf/app.dev.ini ./.docker/php/conf/xdebug.ini $PHP_INI_DIR/conf.d/
RUN echo "mailhub=mailcatcher:1025\nUseTLS=NO\nFromLineOverride=YES" > /etc/ssmtp/ssmtp.conf
CMD [ "frankenphp", "run", "--config", "/etc/caddy/Caddyfile", "--watch" ]
