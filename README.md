**canvas-box** sets up a virtual machine for developing [Canvas LMS](https://github.com/instructure/canvas-lms). Inspired by [jhuckabee/canvas-lms-dev-box](https://github.com/jhuckabee/canvas-lms-dev-box/).

### Step 1
Install [Vagrant](http://www.vagrantup.com/).

### Step 2
```bash
git clone https://github.com/aaronshaf/canvas-box.git
cd canvas-box
git clone https://github.com/instructure/canvas-lms.git canvas
vagrant up
```

### Step 3
Eat breakfast. With the precise32.box already downloaded, it took about 25-30 minutes on my MacBook Pro (16gb).

<img src="http://www.minutedeli.com/breakfast.jpg" />

### Step 4

Open *localhost:3000*

user: a@a.com, password: password

Changes in your project directory [are synced](http://docs.vagrantup.com/v2/getting-started/synced_folders.html) to the ```/vagrant``` directory in your guest machine.

To SSH into the guest machine: ```vagrant ssh```

With Vagrant, you can [suspend, halt, or destroy the guest machine](http://docs.vagrantup.com/v2/getting-started/teardown.html).

To suspend and resume:

```bash
vagrant suspend
vagrant up
```

To shutdown and resume:

```bash
vagrant halt
vagrant up
```

To destroy and rebuild:


```bash
vagrant destroy
vagrant up
```