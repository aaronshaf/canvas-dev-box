#!/usr/bin/env bash

sudo apt-get update

sudo apt-get install git-core python-software-properties python g++ make \
  ruby1.9.1 ruby1.9.1-dev zlib1g-dev rubygems1.9.1 \
  libxml2-dev libxslt1-dev libsqlite3-dev libhttpclient-ruby \
  imagemagick irb1.9.1 libxmlsec1-dev postgresql \
  python-software-properties libcurl3-dev libpq-dev \
  redis-server expect-lite -y

#ruby-bundler 

sudo su -l postgres -c 'psql -c "CREATE ROLE vagrant WITH SUPERUSER LOGIN;"'
sudo su -l postgres -c 'createdb canvas_development'
sudo su -l postgres -c 'createdb canvas_queue_development'

sudo add-apt-repository ppa:chris-lea/node.js -y
sudo apt-get update
sudo apt-get install nodejs -y

sudo npm install -g coffee-script -y

sudo update-alternatives --set ruby /usr/bin/ruby1.9.1

cp /vagrant/canvas/config/database.yml.example /vagrant/canvas/config/database.yml

cp /vagrant/config/security.yml /vagrant/canvas/config/security.yml
cp /vagrant/config/development-local.rb /vagrant/canvas/config/environments/development-local.rb
cp /vagrant/config/cache_store.yml /vagrant/canvas/config/cache_store.yml
cp /vagrant/config/redis.yml /vagrant/canvas/config/redis.yml
cp /vagrant/config/domain.yml /vagrant/canvas/config/domain.yml

mkdir ~/gems
export GEM_HOME=~/gems

cd /vagrant/canvas
gem install bundler
$GEM_HOME/bin/bundle install --without mysql
expect-lite -c ../config/db-initial-setup.elt
$GEM_HOME/bin/bundle exec rake canvas:compile_assets
$GEM_HOME/bin/bundle exec script/server
