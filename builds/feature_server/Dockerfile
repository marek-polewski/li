FROM debian:jessie

RUN apt-get update && \
	apt-get install --no-install-recommends -qq --force-yes \
            apache2 python-gdal python-simplejson python-cheetah python-psycopg2 wget \
		python-shortuuid python-lxml && \
                apt-get clean && \
                    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
			a2enmod cgi

# apache config
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

# copy source
RUN wget --no-check-certificate -qO- https://github.com/iocast/featureserver/archive/master.tar.gz | tar xvz -C /var/www/ && \
	rm -rf /var/www/html/ && mv /var/www/featureserver-master /var/www/html
# feature server config
COPY featureserver.cfg /var/www/html/featureserver.cfg

ENV APACHE_RUN_USER=www-data \
	APACHE_RUN_GROUP=www-data \
	APACHE_LOG_DIR=/var/log/apache2 \
	APACHE_PID_FILE=/var/run/apache2/apache2.pid \
	APACHE_LOG_DIR=/var/log/apache2 \
	APACHE_LOCK_DIR=/var/lock/apache2 \
	APACHE_RUN_DIR=/var/run/apache2

# run apache
EXPOSE 80
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
