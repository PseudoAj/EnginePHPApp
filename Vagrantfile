# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
PROJECT_NAME = "Engine PHP App"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define PROJECT_NAME, primary: true do |config|
    config.vm.provider :virtualbox do |vb|
      vb.name = PROJECT_NAME
    end

    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "bento/centos-7.2"
    config.vm.network "private_network", ip: "192.168.33.10"
    config.vm.network :forwarded_port, guest: 80, host: 8056
    config.vm.network :forwarded_port, guest: 10000, host: 10001

    config.vm.provision "shell", path: "bootstrap.sh"

  end
end
