**canvas-box** sets up a virtual machine for developing [Canvas LMS](https://github.com/instructure/canvas-lms). It was inspired by [jhuckabee/canvas-lms-dev-box](https://github.com/jhuckabee/canvas-lms-dev-box/).

### Step 1
Install [Vagrant](http://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

### Step 2
```
git clone https://github.com/aaronshaf/canvas-box.git
cd canvas-box
git clone https://github.com/instructure/canvas-lms.git canvas
vagrant up
```

### Step 3
Eat breakfast. With the precise32.box already downloaded, it took about 25-30 minutes on my MacBook Pro (16gb).

<img src="http://www.minutedeli.com/breakfast.jpg" />

### Step 4

Open [http://localhost:3000](http://localhost:3000) in your browser. Your initial Canvas user is ```a@a.com``` with a password of ```password```.

To SSH into the guest machine, ```vagrant ssh``` from your project directory. You will probably want to start guard:

```
cd /vagrant/canvas
sudo bundle exec guard
```

Changes in your project directory [are synced](http://docs.vagrantup.com/v2/getting-started/synced_folders.html) to the ```/vagrant``` directory in your guest machine.

With Vagrant, you can [suspend, halt, or destroy the guest machine](http://docs.vagrantup.com/v2/getting-started/teardown.html).

To suspend and resume:

```
vagrant suspend
vagrant up
```

To shutdown and resume:

```
vagrant halt
vagrant up
```

To destroy and rebuild:


```
vagrant destroy
vagrant up
```

## To do

* Use [sstephenson/rbenv](https://github.com/sstephenson/rbenv)