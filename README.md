# Ubuntu Xenial LAMP Vagrant Box

The [ArminVieweg/ubuntu-xenial64-lamp](https://app.vagrantup.com/ArminVieweg/boxes/ubuntu-xenial64-lamp) vagrant box
a lightweight (<700MB) based on latest Ubuntu Xenial 64-bit. The following components are installed:

* Apache 2
* PHP 5.6, 7.0, 7.1, 7.2
* XDebug for all versions (except 7.2)
* MariaDB
* ImageMagick
* Composer


## Installation

Just perform a `vagrant init ArminVieweg/ubuntu-xenial64-lamp` in your project to use this box.
This will create a very basic *Vagrantfile* for you. You can also ship your own *Vagrantfile* with
configured synced_folders, e.g.

You may use the Vagrantfile in this repository. Put the file to your project's root and perform a `vagrant up`.


## Basics

* The default document root is `/var/www/html`.
* MySQL root user has no password set.
* Use `vagrant`/`vagrant` to login with ssh (or `vagrant ssh`)


## Configuration

In home directory of vagrant user are some php.ini files located, which are symlinked in conf.d folders of php versions.
The following files are existing:

* **php-5.6.ini** Just used with PHP 5.6
* **php-7.0.ini** Just used with PHP 7.0
* **php-7.1.ini** Just used with PHP 7.1
* **php-7.2.ini** Just used with PHP 7.2
* **php-all.ini** Used with all versions (not CLI)
* **php-cli.ini** Used for CLI usage (all versions)
* **php-xdebug.ini** Settings for XDebug


### Switch between PHP versions

To switch PHP versions just execute:

`$ sudo ~/enable-php/7.2.sh`

Available versions:

* 5.6.sh
* 7.0.sh
* 7.1.sh
* 7.2.sh

Apache is automatically restarted and also CLI PHP version is changed.
