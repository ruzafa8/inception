#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

if [ -d "/var/lib/mysql/$SQL_DATABASE" ]
then 
	echo "Database already exists"
else
  /etc/init.d/mariadb setup
  rc-service mariadb start

  while ! mysqladmin ping --silent; do
    sleep 1
  done

  mariadb -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
  mariadb -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
  mariadb -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
  mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
  # mysql -e "FLUSH PRIVILEGES;"

  mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
fi
exec mysqld_safe