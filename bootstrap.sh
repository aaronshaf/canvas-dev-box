echo 
echo --- installing some basic dependencies ---
echo

# echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list

sudo apt-get update -qq

sudo apt-get install git-core python-software-properties python g++ make \
  zlib1g-dev libxml2-dev libxslt1-dev libsqlite3-dev  \
  imagemagick libxmlsec1-dev libcurl3-dev libpq-dev screen -y --quiet

echo 
echo --- installing redis ---
echo

sudo add-apt-repository ppa:chris-lea/redis-server -y
sudo apt-get update -qq
sudo apt-get install redis-server --quiet -y

echo 
echo --- installing node, npm, coffeescript ---
echo

sudo add-apt-repository ppa:chris-lea/node.js -y
sudo apt-get update -qq
sudo apt-get install nodejs -y
sudo npm install -g coffee-script --quiet -y

echo 
echo --- installing postgresql ---
echo

sudo apt-get install postgresql --quiet -y
sudo su -l postgres -c 'psql -c "CREATE ROLE root WITH SUPERUSER LOGIN;"'
sudo su -l postgres -c 'psql -c "CREATE ROLE vagrant WITH SUPERUSER LOGIN;"'
sudo su -l postgres -c 'createdb canvas_development'
sudo su -l postgres -c 'createdb canvas_queue_development'

echo 
echo --- copying configuration files ---
echo

cp /vagrant/canvas/config/database.yml.example /vagrant/canvas/config/database.yml
cp /vagrant/config/security.yml /vagrant/canvas/config/security.yml
cp /vagrant/config/development-local.rb /vagrant/canvas/config/environments/development-local.rb
cp /vagrant/config/cache_store.yml /vagrant/canvas/config/cache_store.yml
cp /vagrant/config/redis.yml /vagrant/canvas/config/redis.yml
cp /vagrant/config/domain.yml /vagrant/canvas/config/domain.yml

echo 
echo --- ruby ---
echo

sudo apt-get install ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 libhttpclient-ruby --quiet -y
sudo update-alternatives --set ruby /usr/bin/ruby1.9.1

echo
echo --- bundler ---
echo

sudo su vagrant
mkdir /home/vagrant/gems
export GEM_HOME=/home/vagrant/gems
cd /vagrant/canvas
sudo gem install bundler
bundle install --without mysql
sudo echo "cd /vagrant/canvas" >> /home/vagrant/.bash_profile
sudo echo "export GEM_HOME=~/gems" >> /home/vagrant/.bash_profile