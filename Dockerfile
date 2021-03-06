FROM php:7.4-apache

# Install dependencies
RUN apt-get update && \
	apt-get install -y libpng-dev libpq-dev libzip-dev unzip && \
	apt-get clean && \
	a2enmod rewrite && \
	service apache2 restart

# Install php extensions
RUN docker-php-ext-install bcmath gd mysqli pgsql zip

ENV FS_VERSION 2020.4

# Download FacturaScripts
ADD https://facturascripts.com/DownloadBuild/1/${FS_VERSION} /tmp/facturascripts.zip

# Unzip
RUN unzip -q /tmp/facturascripts.zip -d /usr/src/; \
	rm -rf /tmp/facturascripts.zip

VOLUME /var/www/html

COPY facturascripts.sh /usr/local/bin/facturascripts
RUN chmod +x /usr/local/bin/facturascripts
CMD ["facturascripts"]