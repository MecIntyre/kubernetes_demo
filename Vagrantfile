# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.provision "shell", path: "scripts/bootstrap.sh"
  config.vm.define "rt-b" do |rtb|
    rtb.vm.hostname = "rt-b"
    rtb.vm.network "private_network", ip: "192.168.100.2"
    rtb.vm.provider "virtualbox" do |vb|
      vb.name = "rt-b"
      vb.cpus = "2"
      vb.memory = "2048"
    end
    rtb.vm.provision "shell", path: "scripts/rtb-provision.sh"
  end
  (1..3).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.hostname = "node-#{i}"
      node.vm.network "private_network", ip: "192.168.100.10#{i}"
      node.vm.provision "shell", path: "scripts/node-defaultroute.sh", run: "always"
      node.vm.provision "shell", path: "scripts/node-provision.sh"
      node.vm.provider "virtualbox" do |vb|
        vb.name = "node-#{i}"
        vb.cpus = "2"
        vb.memory = "4096"
      end
    end
  end
end
