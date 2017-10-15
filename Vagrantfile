# -*- mode: ruby -*-
# vi: set ft=ruby :

if Vagrant::Util::Platform.windows? then
    unless Vagrant.has_plugin?("vagrant-winnfsd")
        system "vagrant plugin install vagrant-winnfsd"
    end
end
unless Vagrant.has_plugin?("vagrant-bindfs")
    system "vagrant plugin install vagrant-bindfs"
end
unless Vagrant.has_plugin?("vagrant-hostmanager")
    system "vagrant plugin install vagrant-hostmanager"
end

Vagrant.configure("2") do |config|
  # Base configuration
  config.vm.box = "ArminVieweg/ubuntu-xenial64-lamp"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 2
  end

  # Synchronization
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/var/nfs", type: "nfs"

  config.bindfs.bind_folder "/var/nfs", "/vagrant"
  config.bindfs.bind_folder "/var/nfs", "/var/www/html"

  config.bindfs.default_options = {
    force_user:   "vagrant",
    force_group:  "www-data",
    perms:        "u=rwX:g=rwX:o=rD"
  }

  # Hostmanager
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
  config.vm.define 'default' do |node|
    node.vm.hostname = 'xenial-vagrant'
    node.vm.network :private_network, ip: '192.168.155.15'
    node.hostmanager.aliases = %w(xenial.vagrant xenial.local)
  end
end
