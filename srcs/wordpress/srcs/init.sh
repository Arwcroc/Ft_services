#! /bin/sh

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
						--url=http://192.168.49.2:30050 \
						--title=ft_services \
						--admin_user=user \
						--admin_password=password \
						--admin_email=test@test.com \
						--allow-root

	chown -R www:www /var/www/wordpress/
	wp user create flamboux flamboux@test.com --role=author --user_pass=flamboux --path=/var/www/wordpress
	wp user create choupops choupops@test.com --role=author --user_pass=choupops --path=/var/www/wordpress

fi
php-fpm7 -F