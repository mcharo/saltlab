Vagrant.configure('2') do |config|

  vm_box = 'parallels/centos-6.7'

  # saltmaster
  config.vm.define :saltmaster do |saltmaster|
    saltmaster.vm.box = vm_box
    saltmaster.vm.box_check_update = true
    saltmaster.vm.network :private_network, ip: '192.168.37.10'
    saltmaster.vm.network "forwarded_port", guest: 7443, host: 7443
    saltmaster.vm.hostname = 'saltmaster'
    saltmaster.vm.provision :shell, path: "master_bootstrap.sh"
  end

  # minion01
  config.vm.define :minion01 do |minion01|
    minion01.vm.box = vm_box
    minion01.vm.box_check_update = true
    minion01.vm.network :private_network, ip: '192.168.37.11'
    minion01.vm.hostname = 'minion01'
    minion01.vm.provision :shell, path: "minion_bootstrap.sh"
  end

  # minion02
  config.vm.define :minion02 do |minion02|
    minion02.vm.box = 'win2012r2std'
    minion02.vm.box_check_update = true
    minion02.vm.network :private_network, ip: '192.168.37.12'
    minion02.vm.hostname = 'minion02'
    minion02.vm.provision :salt do |salt|
      salt.masterless = false
      install_type = 'stable'
      version = '2016.3.3'
      minion_id = 'minion02'
    end
    minion02.vm.provision :shell, path: "minion_bootstrap.cmd"
  end

end
