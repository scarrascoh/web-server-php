# Web Server with PHP

Image that runs a web server with php

## Build

```bash
docker build -t scarrascoh/web-server-php .
```

## Run

```bash
docker run -ti --name web-server-php -p 8080:80 \
  -v $(pwd)/www:/var/www \
  -v $(pwd)/workdir/var/log/apache2:/var/log/apache2 \
  scarrascoh/web-server-php
```

## Change folder containing site pages

Change the folder from the **-v** argument:

```bash
docker run -ti --name web-server-php -p 8080:80 -v /path/to/new/folder:/var/www scarrascoh/web-server-php
```

## Build server with custom PHP version

By default, the PHP version 7.0 is used. In order to change it, the build argument PHP_VERSION
can be used.

For example, for build the image for PHP version 5.6:

```bash
docker build -t scarrascoh/web-server-php:5.6 --build-arg PHP_VERSION=5.6 .
docker run -ti --name web-server-php-5.6 -p 8080:80 \
  -v $(pwd)/www:/var/www \
  -v $(pwd)/workdir/var/log/apache2:/var/log/apache2 \
  -d scarrascoh/web-server-php:5.6
```


## MySQL

This image can be used in conjunction with MySQL:

```bash
docker run -ti -d \
  --name mysql-server-5.5 \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=1234  \
  -e MYSQL_DATABASE=db1 \
  -e MYSQL_USER=user1 \
  -e MYSQL_PASSWORD=1234 \
  -v $(pwd)/workdir/var/lib/mysql:/var/lib/mysql \
  mysql/mysql-server:5.5
```

For more information: [MySQL](https://hub.docker.com/r/mysql/mysql-server/)

## PHPMyAdmin

This image can be linked with official phpmyadmin image.

```bash
docker run -ti \
  --name phpmyadmin-4.7 \
  -e MYSQL_ROOT_PASSWORD=1234 \
  -e MYSQL_USER=user1 \
  -e MYSQL_PASSWD=1234 \
  --link web-server-php:db \
  -p 8081:80 \
  phpmyadmin/phpmyadmin:4.7
```

For more information: [phphmyadmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/)
