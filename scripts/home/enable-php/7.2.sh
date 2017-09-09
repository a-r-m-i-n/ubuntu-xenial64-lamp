
echo "Set PHP version in Apache2 and CLI to 7.2..."

a2dismod php5.6
a2dismod php7.0
a2dismod php7.1

a2enmod php7.2
service apache2 restart
update-alternatives --set php /usr/bin/php7.2

echo "Done."
