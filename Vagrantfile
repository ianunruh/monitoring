# vim: ft=ruby
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure VAGRANTFILE_API_VERSION do |config|
  config.vm.box = "trusty64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--cpus", "2"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on", "--natdnshostresolver1", "on"]
  end

  config.vm.define "monitoring" do |box|
    box.vm.hostname = "monitoring"
    box.vm.network :private_network, ip: "192.168.12.10"

    box.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end

    box.vm.provision :shell, inline: "cd /vagrant && ./install-all-server.sh"
  end

  config.vm.define "app1" do |box|
    box.vm.hostname = "app1"
    box.vm.network :private_network, ip: "192.168.12.11"

    box.vm.provision :shell, inline: "cd /vagrant && ./install-all-client.sh"
  end
end
