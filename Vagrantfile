# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "heroku-cedar"
  config.vm.box_url = "http://dl.dropbox.com/u/1906634/heroku.box"

  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 443, host: 8443
  config.vm.network :forwarded_port, guest: 3000, host: 8300

  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider :virtualbox do |vb|
    #vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.provision :shell do |shell|
    packages = "libxslt-dev libxml2-dev sqlite3 libsqlite3-dev"
    shell.inline = "sudo apt-get install #{packages}"
    shell.inline = "echo alias 'r=rails' >> /home/vagrant/.bashrc"
  end

end
