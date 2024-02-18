#!/bin/sh

if [ -f /var/www/wordpress/wp-config.php ]; then
  echo "WordPress is already installed"
else
  mkdir -p /var/www/wordpress

  wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /usr/local/bin

  cd /usr/local/bin
  chmod +x wp-cli.phar
  mv wp-cli.phar wp

  cd /var/www/wordpress
  chown -R root:root /var/www/wordpress
  wp core download --allow-root --locale=es_ES

  wp config create --allow-root \
    --dbname=$SQL_DATABASE \
    --dbuser=$SQL_USER \
    --dbpass=$SQL_PASSWORD \
    --dbhost=mariadb:3306 --path='/var/www/wordpress'

  wp core install --allow-root \
    --url=$DOMAIN_NAME/ \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_USR \
    --admin_password=$WP_ADMIN_PWD \
    --admin_email=$WP_ADMIN_EMAIL \
    --skip-email \
    --locale=es_ES

  wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

  wp theme install astra --activate --allow-root
fi

php-fpm81 -F