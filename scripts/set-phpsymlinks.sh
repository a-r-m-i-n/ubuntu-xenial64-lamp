#!/bin/bash


# PHP 5.6
cd /etc/php/5.6/apache2/conf.d
ln -s /home/vagrant/php-xdebug.ini 80-xdebug.ini
ln -s /home/vagrant/php-all.ini 90-php-all.ini
ln -s /home/vagrant/php-5.6.ini 95-php-5.6.ini

# CLI
cd /etc/php/5.6/cli/conf.d
ln -s /home/vagrant/php-xdebug.ini 80-xdebug.ini
ln -s /home/vagrant/php-cli.ini 99-php-cli.ini

# PHP 7.0
cd /etc/php/7.0/apache2/conf.d
ln -s /home/vagrant/php-xdebug.ini 80-xdebug.ini
ln -s /home/vagrant/php-all.ini 90-php-all.ini
ln -s /home/vagrant/php-7.0.ini 95-php-7.0.ini

# CLI
cd /etc/php/7.0/cli/conf.d
ln -s /home/vagrant/php-xdebug.ini 80-xdebug.ini
ln -s /home/vagrant/php-cli.ini 99-php-cli.ini

# PHP 7.1
cd /etc/php/7.1/apache2/conf.d
ln -s /home/vagrant/php-xdebug.ini 80-xdebug.ini
ln -s /home/vagrant/php-all.ini 90-php-all.ini
ln -s /home/vagrant/php-7.1.ini 95-php-7.1.ini

# CLI
cd /etc/php/7.1/cli/conf.d
ln -s /home/vagrant/php-xdebug.ini 80-xdebug.ini
ln -s /home/vagrant/php-cli.ini 99-php-cli.ini

# PHP 7.2
cd /etc/php/7.2/apache2/conf.d
ln -s /home/vagrant/php-xdebug.ini 80-xdebug.ini
ln -s /home/vagrant/php-all.ini 90-php-all.ini
ln -s /home/vagrant/php-7.2.ini 95-php-7.2.ini

# CLI
cd /etc/php/7.2/cli/conf.d
#ln -s /home/vagrant/php-xdebug.ini 80-xdebug.ini
ln -s /home/vagrant/php-cli.ini 99-php-cli.ini
