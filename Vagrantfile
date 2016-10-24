Vagrant.configure("2") do |config|

  config.vm.define "master01" do |master01|
    master01.vm.box = "puppet-ubuntu14"
    master01.vm.synced_folder ".", "/vagrant", disabled: true
    master01.vm.synced_folder "sync/", "/vagrant"
    master01.vm.hostname = "master01"
    master01.vm.provision :shell, path: "master01.sh"
    master01.vm.network "forwarded_port", guest: 5000, host: 5000, protocol: "udp"
    master01.vm.network "forwarded_port", guest: 9200, host: 9200
    master01.vm.network "forwarded_port", guest: 9300, host: 9300
    master01.vm.network "forwarded_port", guest: 5601, host: 5601
  end

  config.vm.define "slave01" do |slave01|
    slave01.vm.box = "puppet-ubuntu14"
    slave01.vm.synced_folder ".", "/vagrant", disabled: true
    slave01.vm.synced_folder "sync/", "/vagrant"
    slave01.vm.hostname = "slave01"
    slave01.vm.provision :shell, path: "slave.sh"
  end

  config.vm.define "slave02" do |slave02|
    slave02.vm.box = "puppet-ubuntu14"
    slave02.vm.synced_folder ".", "/vagrant", disabled: true
    slave02.vm.synced_folder "sync/", "/vagrant"
    slave02.vm.hostname = "slave02"
    slave02.vm.provision :shell, path: "slave.sh"
  end

  config.vm.define "slave03" do |slave03|
    slave03.vm.box = "puppet-ubuntu14"
    slave03.vm.synced_folder ".", "/vagrant", disabled: true
    slave03.vm.synced_folder "sync/", "/vagrant"
    slave03.vm.hostname = "slave03"
    slave03.vm.provision :shell, path: "slave.sh"
  end

end
