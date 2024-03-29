# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "bento/ubuntu-18.10"
  config.vm.hostname = "ACEDevBox"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 8881, host: 8881

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "172.16.0.2"
  config.vm.network "private_network", ip: "55.55.55.5"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "c:/vagrant-home", "/host-share"

  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true

    # Fix the resolver
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    # bash /vagrant/test.bash
    echo "Provisioning Virtual Machine..."
    sudo apt-get update

    echo "Configuring 1G of Swapfile"
    sudo fallocate -l 1G /swapfile
    sudo chmod 600 /swapfile
    ls -lh /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile

    echo "Installing developer packages..."
    sudo apt-get install build-essential #| curl vim -y > /dev/null

    echo "Installing Git..."
    sudo apt-get install git -y > /dev/null

    echo "Installing Node and NVM..."
    curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
    source ~/.nvm/nvm.sh
    nvm install node
    nvm alias default node

    cd /vagrant

    echo "Installing Node dependencies..."
    npm install -g webpack
    npm install
    npm shrinkwrap --dev

    echo "Installing React..."
    npm install -g create-react-app

    echo "Installing Meteor..."
    curl https://install.meteor.com/ | sh

    echo Preparing Samba fileshare
    cp /vagrant/samba-public-share.bash ~
    sudo bash ~/samba-public-share.bash

    echo Access on host machine at 55.55.55.5
    echo

    echo Installing wave-cli deployment tool
    npm i wave-cli

    # echo Creating sample meteor project
    
    # cd /home/vagrant
    # meteor create meteor-example

    # echo Creating sample React project
    # npx create-react-app react-example

    # Install nginx
    echo Installing Nginx to act as a reverse proxy, rerouting HTTP requests on port 80
    echo to the node.js application running on port 3000.
    sudo apt-get -y install nginx

    # Remove default configuration
    sudo rm /etc/nginx/sites-enabled/default

    # Create a configuration file for http reverse proxy and add the correct settings
    echo 'server {'   | sudo tee --append /etc/nginx/sites-available/node
    echo '    listen 80;'   | sudo tee --append /etc/nginx/sites-available/node
    echo '    server_name acedevbox;'   | sudo tee --append /etc/nginx/sites-available/node
    echo ''   | sudo tee --append /etc/nginx/sites-available/node
    echo '    location / {'   | sudo tee --append /etc/nginx/sites-available/node
    echo '        proxy_set_header   X-Forwarded-For $remote_addr;'   | sudo tee --append /etc/nginx/sites-available/node
    echo '        proxy_set_header   Host $http_host;'   | sudo tee --append /etc/nginx/sites-available/node
    echo '        proxy_pass         "http://127.0.0.1:3000";'   | sudo tee --append /etc/nginx/sites-available/node
    echo '    }'   | sudo tee --append /etc/nginx/sites-available/node
    echo '}'   | sudo tee --append /etc/nginx/sites-available/node

    # Create a symbolic link to create a link to the configuration in sites-available
    # in sites-enabled to enable the reverse proxy
    sudo ln -s /etc/nginx/sites-available/node /etc/nginx/sites-enabled/node
    sudo service nginx restart
  SHELL
end
