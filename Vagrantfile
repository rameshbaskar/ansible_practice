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

    host_os = RbConfig::CONFIG['host_os']
    case host_os
      when /darwin/
        host_cpus = `sysctl -n hw.ncpu`.to_i
        host_memory = `sysctl -n hw.memsize`.to_i / 1024 / 1024
      when /linux/
        host_cpus = `nproc`.to_i
        host_memory = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024
    end

    vb.customize ["modifyvm", :id, "--cpus", (host_cpus / 4)]
    vb.customize ["modifyvm", :id, "--memory", (host_memory / 4)]
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
