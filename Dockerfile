FROM ubuntu:16.04
LABEL maintainer="scarrascoh.develop@gmail.com" \
      version=1.0.0 \
      description="Web Server with PHP and Apache"

ARG PHP_VERSION=7.0

RUN apt-get update && \
    apt-get -y --no-install-recommends install software-properties-common python-software-properties

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C && \
    LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && \
    LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php5-compat

RUN apt-get update && \
    apt-get -y --no-install-recommends install apache2 php${PHP_VERSION} php${PHP_VERSION}-mysql libapache2-mod-php${PHP_VERSION} && \
    rm -rf /var/lib/apt/lists/*

RUN a2enmod php${PHP_VERSION} && \
    a2enmod rewrite && \
    a2enmod include && \
    sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/${PHP_VERSION}/apache2/php.ini && \
    sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/${PHP_VERSION}/apache2/php.ini && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf

EXPOSE 80

ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_LOG_DIR=/var/log/apache2
ENV APACHE_LOCK_DIR=/var/lock/apache2
ENV APACHE_PID_FILE=/var/run/apache2.pid

ADD cfg/apache2.conf /etc/apache2/sites-enabled/000-default.conf

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
