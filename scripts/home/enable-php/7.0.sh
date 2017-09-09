
echo "Set PHP version in Apache2 and CLI to 7.0..."

a2dismod php5.6
a2dismod php7.1
a2dismod php7.2

a2enmod php7.0
service apache2 restart
update-alternatives --set php /usr/bin/php7.0

echo "Done."
