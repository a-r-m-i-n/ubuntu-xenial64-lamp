# -*- mode: ruby -*-
# vi: set ft=ruby :

# Requires to perform this first once:
#  vagrant plugin install vagrant-winnfsd
#  vagrant plugin install vagrant-bindfs

Vagrant.configure("2") do |config|
  # Base configuration
  config.vm.box = "ArminVieweg/ubuntu-xenial64-lamp"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", type: "dhcp"

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/var/nfs", type: "nfs"

  config.bindfs.bind_folder "/var/nfs", "/vagrant"
  config.bindfs.bind_folder "/var/nfs", "/var/www/html"
  config.bindfs.default_options = {
    force_user:   "vagrant",
    force_group:  "www-data",
    perms:        "u=rwX:g=rwX:o=rD"
  }

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 2
  end

  # Provider Scripts
  # Run always
  config.vm.provision "shell", run: "always", inline: <<-SHELL
    cd ~
    sudo composer self-update --no-progress
  SHELL

  # Run once
  config.vm.provision "shell", inline: <<-SHELL
  SHELL

end
