#! /bin/sh

if [ ! -f /var/www/phpmyadmin/phpmyadmin/config.inc.php ]
then
	mkdir -p ./var/www/phpmyadmin/
	wget https://files.phpmyadmin.net/phpMyAdmin/4.9.3/phpMyAdmin-4.9.3-english.tar.gz -P /tmp
	tar xzf /tmp/phpMyAdmin-4.9.3-english.tar.gz -C /var/www/phpmyadmin/
	cp -R /var/www/phpmyadmin/phpMyAdmin-4.9.3-english /var/www/phpmyadmin/phpmyadmin
	rm -rf /var/www/phpmyadmin/phpMyAdmin-4.9.3-english
	cp /var/www/phpmyadmin/config.inc.php /var/www/phpmyadmin/phpmyadmin/config.inc.php
fi
php-fpm7 -F