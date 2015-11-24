FROM ubuntu:14.04
MAINTAINER Julian Labuschagne "personxx@gmail.com"
ENV REFRESHED_AT 2015-11-24
ENV TERM linux

RUN apt-get -yqq update && apt-get -yqq upgrade 
RUN apt-get -yq install \ 
	apache2 \
	php5 \
	php5-dev \
	php5-cli \
	php5-gd \
	php5-mysql \
	php-pear \
	gcc \
	libpcre3-dev \
	rsync \
	git-core \
	unzip \
	curl \
	supervisor \
	software-properties-common

RUN cd /opt && git clone git://github.com/phalcon/cphalcon.git
RUN cd /opt/cphalcon/build && ./install

RUN a2enmod rewrite
RUN echo "extension=phalcon.so" >> /etc/php5/mods-available/phalcon.ini
RUN php5enmod phalcon

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME /var/www/webdev/platforms
VOLUME /etc/apache2/sites-enabled

EXPOSE 80
CMD ["/usr/bin/supervisord"]
