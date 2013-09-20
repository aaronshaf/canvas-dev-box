#!/usr/bin/env bash

echo 
echo Setting up VM for Canvas LMS. This should take about 25-30 minutes. Get some breakfast.
echo

sudo su
apt-get update

apt-get install git-core python-software-properties python g++ make \
  ruby1.9.1 ruby1.9.1-dev zlib1g-dev rubygems1.9.1 \
  libxml2-dev libxslt1-dev libsqlite3-dev libhttpclient-ruby \
  imagemagick irb1.9.1 libxmlsec1-dev postgresql \
  python-software-properties libcurl3-dev libpq-dev \
  expect-lite -y

add-apt-repository ppa:chris-lea/redis-server -y
apt-get update
apt-get install redis-server -y

add-apt-repository ppa:chris-lea/node.js -y
apt-get update
apt-get install nodejs -y

su -l postgres -c 'psql -c "CREATE ROLE root WITH SUPERUSER LOGIN;"'
su -l postgres -c 'psql -c "CREATE ROLE vagrant WITH SUPERUSER LOGIN;"'
su -l postgres -c 'createdb canvas_development'
su -l postgres -c 'createdb canvas_queue_development'

npm install -g coffee-script -y

update-alternatives --set ruby /usr/bin/ruby1.9.1

cp /vagrant/canvas/config/database.yml.example /vagrant/canvas/config/database.yml
cp /vagrant/config/security.yml /vagrant/canvas/config/security.yml
cp /vagrant/config/development-local.rb /vagrant/canvas/config/environments/development-local.rb
cp /vagrant/config/cache_store.yml /vagrant/canvas/config/cache_store.yml
cp /vagrant/config/redis.yml /vagrant/canvas/config/redis.yml
cp /vagrant/config/domain.yml /vagrant/canvas/config/domain.yml

cd /vagrant/canvas
gem install bundler
bundle install --without mysql
expect-lite -c /vagrant/config/db-initial-setup.elt
bundle exec rake canvas:compile_assets
bundle exec script/server
