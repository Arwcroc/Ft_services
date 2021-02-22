#! /bin/sh

sleep 15
if [ ! -f /var/www/wordpress/wp-config.php ]
then
	wp core download	--path=/var/www/wordpress --allow-root
	sleep 20
	wp config create	--dbuser=$DB_USER \
						--dbname=$DB_NAME \
						--dbhost=$DB_HOST \
						--dbpass=$DB_PASSWORD \
						--path=/var/www/wordpress \
						--allow-root

	wp core install		--path=/var/www/wordpress/ \
						--url=http://192.168.49.3:5050 \
						--title=ft_services \
						--admin_user=$DB_USER \
						--admin_password=$DB_PASSWORD \
						--admin_email=test@test.com \
						--allow-root

	wp user create flamboux flamboux@test.com --role=author --user_pass=flamboux --path=/var/www/wordpress --allow-root
	wp user create choupops choupops@test.com --role=author --user_pass=choupops --path=/var/www/wordpress --allow-root
fi
php-fpm7 -F