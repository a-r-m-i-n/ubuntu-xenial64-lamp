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
unless Vagrant.has_plugin?("vagrant-triggers")
    system "vagrant plugin install vagrant-triggers"
end

Vagrant.configure("2") do |config|
    # Base configuration
    config.vm.box = "ArminVieweg/ubuntu-xenial64-lamp"

    staticIdAddress = "192.168.11.15"
    httpPortForwardingHost = "8080"
    config.vm.hostname = "xenial.vagrant"
    
    if Vagrant::Util::Platform.windows? then
        config.trigger.after :up, :good_exit => [0, 1] do
            run "explorer http://#{config.vm.hostname}"
        end
    end

    config.vm.network "private_network", type: "dhcp"
    config.vm.provider "virtualbox" do |vb|
        vb.memory = 4096
        vb.cpus = 2
    end

    # Synchronization
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.synced_folder ".", "/var/nfs", type: "nfs"

    config.bindfs.bind_folder "/var/nfs", "/vagrant",
        perms: "u=rwX:g=rwX:o=rD"
    config.bindfs.bind_folder "/var/nfs", "/var/www/html",
        perms: "u=rwX:g=rwX:o=rD", force_user: "vagrant", force_group: "www-data"

    # Hostmanager
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

    config.vm.define "default" do |node|
        node.vm.network :private_network, ip: staticIdAddress
        node.vm.network :forwarded_port, guest: 80, host: httpPortForwardingHost
    end

    # Provider Scripts
    # Run always
    config.vm.provision "shell", run: "always", inline: <<-SHELL
        cd ~
        composer self-update --no-progress
    SHELL

end
