echo 
echo --- installing some basic dependencies ---
echo

sudo apt-get update -qq
sudo apt-get install python-software-properties git-core python g++ make \
  zlib1g-dev  \
  libxml2-dev libxslt1-dev libsqlite3-dev  \
  imagemagick  libxmlsec1-dev postgresql \
  python-software-properties libcurl3-dev libpq-dev \
  expect-lite screen --quiet -y

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
echo --- installing ruby, bundler ---
echo

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
export PATH="$HOME/.rbenv/bin:$PATH"
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
eval "$(rbenv init -)"
rbenv install 1.9.3-p448
rbenv rehash

rm -fr ~/.rbenv/plugins/bundler
git clone git://github.com/carsomyr/rbenv-bundler.git ~/.rbenv/plugins/bundler

cd /vagrant/canvas
rbenv global 1.9.3-p448
gem install bundler

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

echo 'cd /vagrant/canvas' >> ~/.bash_profile

# bundle install --without mysql
# expect-lite -c /vagrant/config/db-initial-setup.elt
# bundle exec rake canvas:compile_assets
# bundle exec script/server

