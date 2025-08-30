service mysql start
mysql -e "\
	CREATE DATABASE IF NOT EXISTS \`$db_name\`; \
	CREATE USER IF NOT EXISTS '$db_username'@'%' IDENTIFIED BY '$db_password'; \
	GRANT ALL PRIVILEGES ON \`$db_name\`.* TO '$db_username'@'%'; \
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$db_root_password'; \
	FLUSH PRIVILEGES; \
	"
mysqld
