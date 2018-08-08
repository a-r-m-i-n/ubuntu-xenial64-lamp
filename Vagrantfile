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

    staticIpAddress = "192.168.11.2"
    httpPortForwardingHost = "8080"
    config.vm.hostname = "xenial.local"
    
	config.ssh.insert_key = false

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
        node.vm.network :private_network, ip: staticIpAddress
        node.vm.network :forwarded_port, guest: 80, host: httpPortForwardingHost
    end

    # Provider Scripts

    # Run once
    config.vm.provision "shell", run: "once", name: "update-ssl-certificate", inline: <<-SHELL
        openssl genrsa -des3 -passout pass:xxxx -out /tmp/server.pass.key 2048 2>/dev/null
        openssl rsa -passin pass:xxxx -in /tmp/server.pass.key -out /etc/apache2/ssl/apache.key 2>/dev/null
        rm /tmp/server.pass.key
        openssl req -new -key /etc/apache2/ssl/apache.key -out /tmp/server.csr \
          -subj "/C=DE/ST=North Rhine Westphalia/L=Cologne/O=Dev/OU=Dev/CN=#{config.vm.hostname}" 2>/dev/null
        openssl x509 -req -days 365 -in /tmp/server.csr -signkey /etc/apache2/ssl/apache.key \
          -out /etc/apache2/ssl/apache.crt 2>/dev/null
        rm /tmp/server.csr
        service apache2 restart
    SHELL

    # Run always
    config.vm.provision "shell", run: "always", name: "update-composer", inline: <<-SHELL
        cd ~
        composer self-update --no-progress
    SHELL

end
