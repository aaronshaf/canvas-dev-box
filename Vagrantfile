VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box       = 'precise32'
  config.vm.box_url   = 'http://files.vagrantup.com/precise32.box'
  config.vm.host_name = 'canvas-box'

  # config.vm.customize ["modifyvm", :id, "--memory", 1024]

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :shell, :path => "bootstrap.sh"
end