
echo "Set PHP version in Apache2 and CLI to 5.6..."

a2dismod php7.0
a2dismod php7.1
a2dismod php7.2

a2enmod php5.6
service apache2 restart
update-alternatives --set php /usr/bin/php5.6

echo "Done."
