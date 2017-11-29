DOMAIN="example.com"
ubuntu14_box="ubuntu/trusty64"
ubuntu16_box="ubuntu/xenial64"
centos6_box="centos/6"
centos7_box="centos/7"
common_bootstrap="bootstrap.sh"
salt_install="salt_install.sh"
net_ip = "192.168.40"

Vagrant.configure(2) do |config|

  config.vm.define "saltmaster" do |satlmaster|
    satlmaster.vm.box = "#{ubuntu14_box}"
    satlmaster.vm.network "private_network", ip: "#{net_ip}.11"
    satlmaster.vm.hostname = "saltmaster.#{DOMAIN}"
    satlmaster.vm.provision :shell, path: "#{common_bootstrap}"
    satlmaster.vm.provision "shell" do |s|
	s.path = "#{salt_install}"
	s.args = "salt-master"
    end
    # ubuntu don't need vbguest
    satlmaster.vbguest.auto_update = false
    satlmaster.vbguest.no_install = true

    satlmaster.vm.synced_folder "saltstack/salt/", "/srv/salt"
    satlmaster.vm.synced_folder "saltstack/pillar/", "/srv/pillar"
  end

  config.vm.define "ubuntu01" do |ubuntu|
    ubuntu.vm.box = "#{ubuntu14_box}"
    ubuntu.vm.network "private_network", ip: "#{net_ip}.12"
    ubuntu.vm.hostname = "ubuntu01.#{DOMAIN}"
    ubuntu.vm.provision :shell, path: "#{common_bootstrap}"
    ubuntu.vm.provision "shell" do |s|
	s.path = "#{salt_install}"
	s.args = "salt-minion"
    end
    # ubuntu don't need vbguest
    ubuntu.vbguest.auto_update = false
    ubuntu.vbguest.no_install = true
  end
 
  config.vm.define "ubuntu02" do |ubuntu|
    ubuntu.vm.box = "#{ubuntu16_box}"
    ubuntu.vm.network "private_network", ip: "#{net_ip}.13"
    ubuntu.vm.hostname = "ubuntu02.#{DOMAIN}"
    ubuntu.vm.provision :shell, path: "#{common_bootstrap}"
    ubuntu.vm.provision "shell" do |s|
	s.path = "#{salt_install}"
	s.args = "salt-minion"
    end
    # ubuntu don't need vbguest
    ubuntu.vbguest.auto_update = false
    ubuntu.vbguest.no_install = true
  end
#
#  config.vm.define "centos6" do |centos|
#    centos.vm.box = "#{centos6_box}"
#    centos.vm.network "private_network", ip: "192.168.40.13"
#    centos.vm.hostname = "centos6.#{DOMAIN}"
#    centos.vm.provision :shell, path: "#{common_bootstrap}"
#    centos.vbguest.auto_update = false
#  end
#
#  config.vm.define "centos7" do |centos|
#    centos.vm.box = "#{centos7_box}"
#    centos.vm.network "private_network", ip: "192.168.33.15"
#    centos.vm.hostname = "centos7.#{DOMAIN}"
#    centos.vm.provision :shell, path: "#{common_bootstrap}"
#    centos.vbguest.auto_update = false
#  end

end
