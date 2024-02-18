FROM alpine:3.18

RUN apk update && apk upgrade \
	&& apk add vim wget \
		php php-fpm php-mysqli php-phar php-iconv \
		mariadb-client

# RUN wget https://wordpress.org/wordpress-6.4.3.tar.gz -P /var/www

# RUN cd /var/www && tar -xzf wordpress-6.4.3.tar.gz && rm wordpress-6.4.3.tar.gz

# RUN chown -R root:root /var/www/wordpress

COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

COPY tools/wp-config.sh /scripts/entrypoint.sh

RUN chmod +x /scripts/entrypoint.sh

entrypoint ["sh"]
CMD ["/scripts/entrypoint.sh"]