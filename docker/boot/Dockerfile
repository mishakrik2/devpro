FROM alpine:latest

# Install Nginx

RUN apk update && \
    apk add nginx && \
    mkdir -p /run/nginx && \
    touch /run/nginx/nginx.pid && \
    adduser -D -g 'nginx' www && \
    mkdir /www && \
    chown -R nginx:nginx /var/lib/nginx && \
    chown -R nginx:nginx /www && \
    mkdir -p /var/cache/nginx && \
    chown -R nginx:nginx /var/cache/nginx && \
    mkdir -p /usr/share/nginx/html/

# Install PHP, FPM, extensions.

RUN apk add php7 php7-fpm php7-opcache php7-mbstring php7-session && \
    apk add php7-gd php7-mysqli php7-zlib php7-curl php7-iconv php7-json php7-xml

# Copy configs

COPY files/default.conf /etc/nginx/http.d/
COPY files/index.html /usr/share/nginx/html/index.html
COPY files/www.conf /etc/php7/php-fpm.d/www.conf

# Install PMA.

RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz \
        -P /usr/share/nginx/html/ && \
    tar xvzf /usr/share/nginx/html/phpMyAdmin-latest-all-languages.tar.gz \
        -C /usr/share/nginx/html/ \
        --strip-components=1 && \
    rm /usr/share/nginx/html/phpMyAdmin-latest-all-languages.tar.gz

COPY files/config.inc.php /usr/share/nginx/html/config.inc.php

# Fix permissions on web content and PHP sessions.

RUN chown -R nginx:nginx /usr/share/nginx/html && \ 
    mkdir -p /var/lib/php/session && \
    chown -R nginx:nginx /var/lib/php/session && \
    chmod 777 /var/lib/php/session

# Install supervisord.

RUN apk add --no-cache supervisor

COPY files/supervisord.conf /etc/supervisord.conf

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
