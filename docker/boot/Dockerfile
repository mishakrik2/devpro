FROM alpine:latest

RUN apk add nginx && \
    mkdir -p /run/nginx && \
    touch /run/nginx/nginx.pid && \
    adduser -D -g 'www' www && \
    mkdir /www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www && \
    mkdir -p /var/cache/nginx && \
    chown -R www:www /var/cache/nginx && \
    chown -R www:www /var/tmp/nginx && \
    mkdir -p/usr/share/nginx/html/


COPY files/default.conf /etc/nginx/http.d/
COPY files/index.html /usr/share/nginx/html/index.html
COPY files/www.conf /etc/php7/php-fpm.d/www.conf


RUN chown -R www:www /usr/share/nginx/html


RUN apk add --no-cache supervisor

COPY supervisord.conf /etc

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
