# -*- mode: ruby -*-
# vi: set ft=ruby :

######## DON'T TOUCH ############

VAGRANT_FILE_VERSION = "2"

######## DON'T TOUCH ############

Vagrant.configure(VAGRANT_FILE_VERSION) do |config|
  # Box file URL: https://atlas.hashicorp.com/search.
  config.vm.box = "centos/7"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.enable :yum
  end

  config.vm.provider :virtualbox do |vb|
    vb.name = "centos_mysql_db"

    host = RbConfig::CONFIG['host_os']
    # Give the VM 1/4 system memory & CPU cores
    if host =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i / 4
      # sysctl command returns in bytes. So lets convert to MB before allocating 1/4
      memory = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      cpus = `nproc`.to_i / 2
      # meminfo returns results in KB. So lets convert to MB before allocating 1/4
      memory = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
    else
      # Windows
      cpus = 2
      memory = 1024
    end

    vb.customize ["modifyvm", :id, "--memory", memory]
    vb.customize ["modifyvm", :id, "--cpus", cpus]
  end

  config.vm.define "db" do |db|
    db.vm.hostname="db-centos"
    db.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/vagrant-db.yml"
    end
    db.vm.network "private_network", ip: "192.168.10.10"
    db.vm.network "forwarded_port", guest: 3306, host: 3306, auto_correct: true
  end
end
