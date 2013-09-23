Vagrant.configure("2") do |config|
  ip_address = "192.168.56.101"

  config.vm.box       = 'precise32'
  config.vm.box_url   = 'http://files.vagrantup.com/precise32.box'
  config.vm.host_name = 'canvas-dev-box'

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1536"]
  end

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :public_network
  config.vm.network :private_network, ip: ip_address
  config.vm.synced_folder ".", "/vagrant/", nfs: true

  config.vm.provision :shell, :path => "bootstrap.sh"
end