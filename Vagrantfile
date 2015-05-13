# vim: ft=ruby
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 4
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.define "monitoring" do |box|
    box.vm.hostname = "monitoring"
    box.vm.network "private_network", ip: "192.168.12.10"

    box.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
    end

    box.vm.provision :shell, inline: "cd /vagrant && ./install-all-server.sh"
  end

  config.vm.define "app1" do |box|
    box.vm.hostname = "app1"
    box.vm.network "private_network", ip: "192.168.12.11"

    box.vm.provision "shell", inline: "cd /vagrant && ./install-all-client.sh"
  end
end
