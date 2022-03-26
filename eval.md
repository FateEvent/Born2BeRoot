# The evaluation cheat sheet for Born2BeRoot

## A bit of theory

### Virtualization

Virtualization or hardware virtualization referes to the simulation of a real computer environment by a virtual machine. Softwares executed on a virtual machine are separated by the underlying hardware resources.
We will call host machine the computer in wich virtualization takes place and guest machine the virtual machine.
The software that creates a virtual machine, VirtualBox in our case, is called a hypervisor, or a virtual machine monitor.
The hypervisor uses a part of the host machine's CPU, storage, etc., and distributes them among the different VMs installed.

#### How do Virtual Machines work?

Virtualization allow us to share a system with multiple virtual environments. The hypervisor manages the hardware system and separate the physical resources from the virtual environments. When a user from a VM do a task that requires additional resources from the physical environment, the hypervisor gives them access to the computer's resources.

#### Advantages

* Different guest machines hosted on our computer can run different operating systems, so we will have different operating systems working on the same machine;
* they provide an environment in which safely testing unstable programs;
* shared resources are better used;
* costs are reduced since the physical architecture is reduced;
* VMs are easy to implement because they provide mechanisms to clone themselves into another physical device.

#### A snapshot

A snapshot is a state of a virtual machine at an exact point in time. It allows users to restore a virtual machine's state at the time of the snapshot, effectively undoing any changes that occurred afterwards. This capability is useful as a backup technique, for example, prior to performing a risky operation.

Virtual machines frequently use virtual disks for their storage; a 10-gigabyte hard disk drive, for example, is simulated with a 10-gigabyte flat file. Any requests by the VM for a location on its physical disk are transparently translated into an operation on the corresponding file. Once such a translation layer is present, however, it is possible to intercept the operations and send them to different files, depending on various criteria. Every time a snapshot is taken, a new file is created, and used as an overlay for its predecessors. New data is written to the topmost overlay; reading existing data, however, needs the overlay hierarchy to be scanned, resulting in accessing the most recent version. Thus, the entire stack of snapshots is virtually a single coherent disk; in that sense, creating snapshots works similarly to the incremental backup technique.

Other components of a virtual machine can also be included in a snapshot, such as the contents of its random-access memory (RAM), BIOS settings, or its configuration settings. "Save state" feature in video game console emulators is an example of such snapshots.

Restoring a snapshot consists of discarding or disregarding all overlay layers that are added after that snapshot, and directing all new changes to a new overlay.

A clone, on the other hand, creates a copy of the running machine. It is used to recreate a machine which is configured as the previous one, of which it is a sort of child.
The IP address will be therefore slightly different, since there can't be two machines sharing the same IP address.

### What is the difference between AppArmor and SELinux?

AppArmor ("Application Armor") is a Linux kernel security module that allows the system administrator to restrict programs' capabilities with tailor-made, per-program profiles. Profiles can allow capabilities like network access, raw socket access, and the permission to read, write, or execute files on matching paths. It's what is called mandatory access control (MAC), a type of access control by which the operating system or database constrains the ability of a subject, a process, for example, to access or generally perform some sort of operation on an object, a file, a directory, a TCP/UDP port, etc. Subjects and objects each have a set of security attributes. Whenever a subject tries to accede to an object, their attributes are examined.
It exists, however, two ways in which profiles may work, a "complaint mode" and an "enforce mode". In the last case, the processes are restrained from performing restricted tasks, while in the first one, AppArmor allows applications to do these tasks, but creates a registry entry to display the complaint.
AppArmor is partly offered as an alternative to SELinux, generally considered as difficult for administrators to set up and maintain. Unlike SELinux, which is based on the application of labels to files, AppArmor works with file paths.

SELinux (Security-Enhanced Linux) is a security architecture for Linux systems that allows administrators to better control access to the system. This architecture was originally designed by the NSA, the national security agency of the United States, as a series of fixes for the Linux kernel based on the LSM (Linux Security Modules) framework. 

While AppArmor uses path based control, making the system transparent, SELinux' rule sets are complex, but they enable more control over the isolation of processes. It is, however, very difficult to independently verify how these rules are applied.

### What is the difference between Apt and Aptitude?

In Debian-based OS distributions, the default package manager is dpkg (Debian package). This tool allows us to install, remove and manage programs on our operating system. However, in most cases, these programs come with a list of dependencies that must be installed for the main program to function properly, and we have to install them manually. However, APT (Advanced Package Tool) may install all the necessary dependencies when installing a program. A single command thus allows us to install a software and all its packages.
In case we wanted to use a graphical interface, however, we would have to use Aptitude, the text-based front-end for the APT package management system. It allows the user to view the list of packages and to perform package management tasks such as installing, upgrading, and removing packages either from a visual interface or from the command-line.
It is a high-level package manager, contrarily to Apt, which is a low-level one, so commands are more automatized. For example, Aptitude handles more stuff than apt, including functionalities of apt-mark and apt-cache like searching for a package in a list of installed packages, marking a package to be automatically or manually installed, holding a package making it unavailable for up-gradation and so on.

### What's SSH?

SSH or Secure Shell is a remote administration protocol that allows users to control and modify their servers over the Internet thanks to an authentication mechanism. It provides a mechanism to authenticate a user remotely, transfer data from a client to a host, and return a response to the request made by the client.
SSH was created as an alternative to Telnet, which does not encrypt the transmissions. SSH, on the contrary, makes sure that all communications are encrypted.
To connect to a Linux terminal from a MacOS terminal via an SSH connection type:

	ssh {username}@{IP_host} -p {port}

SSH uses three techniques to encrypt:

* Symmetric encryption: a method that uses the same secret key for both encryption and decryption of a message, for both the client and the host. Anyone who knows the password can access the message that has been transmitted;
* Asymmetric encryption: a method using two separate keys for encryption and decryption. These are known as the public key and the private key. Together, they form the public-private key pair.
* Hashing: hash functions are made in a way that they don't need to be decrypted. If a client has the correct input, they can create a cryptographic hash and SSH will check if both hashes are the same.

### How to implement UFW with SSH

UFW (Uncomplicated Firewall) is a software application responsible for ensuring that the system administrator can manage iptables in a simple way. Since it is very difficult to work with iptables, UFW provides us with an interface to modify the firewall of our device (netfilter) without compromising security. Once we have UFW installed, we can choose which ports we want to open for connections and which ones we want to close. This will also be very useful with SSH, greatly improving all the security related to communications between devices.

### Cron, wall and the useless thing

#### What's Cron?

Cron is a Linux task manager allowing us to execute commands at a certain time. We can automate some tasks just by telling cron what command we want to run at a specific time. For example, if we want to restart our server every day at 4:00 am, instead of having to wake up at that time, cron will do it for us.

#### The wall command

The `wall` command used by the root user to send a message to all users currently connected to the server. If the system administrator wishes to alert about a major server change, the root user could alert them with this command.

### CentOS and Debian

CentOS and Debian are two distributions of Linux.
CentOS is free and open-source, and it's appreciated by industries, which often use it for server building. It is supported by a large community and is functionally supported by its upstream source, Red Hat Enterprise Linux. Debian is a Unix-like computer operating system that is made up of open source components and is built and supported by a group of individuals rallied under the Debian flag.

Debian uses Linux as its Kernel. Fedora, CentOS, Oracle Linux are all different distributions from Red Hat Linux and are its variants. Distributions such Ubuntu and Kali are variants of Debian.
CentOS and Debian both are used as internet servers or web servers like web, email, FTP, etc.

| CentOS | Debian |
| ------ | ------ |
| CentOS is more stable and supported by a large community. | Debian has less market preference. |
| Mission-critical servers are hosted on CentOS. | Ubuntu is fast catching up. |
| CentOS does not support many different architectures. | Debian has more packages. |
| After a major release, the CentOS code is frozen and is never changed except for security flaws or security bugs. This makes some issues while working with it as the next update usually happens after 5 years, and many application software changes in this duration. For example, CentOS 5 supports MySQL 5.1 only, whereas there are newer versions of MySQL available, which CentOS does not support. | Due to rapid development and short testing cycle, most major vendors still prefer CentOS over Debian. For example, Oracle or MySQL team prefer CentOS because these are more stable and thoroughly tested. Most of the developers who build application software on Linux uses Ubuntu as the desktop and still uses CentOS as servers. |
| It does not have an easy GUI (Graphic User Interface). | It has desktop friendly applications and GUI. |
| The core software of CentOS, the kernel and all its utilities, come from the distribution, while the add-on softwares like Apache, PHP, Java, and MySQL come from newer sources such as Fedora or directly from vendors such as MySQL. | Debian provides unique functionalities which are necessary for a system. Apt repositories in package managers have the latest source code for several open-source languages and frameworks like ruby, rails, PostgreSQL, Golang, selenium, angular2-dart, etc. |

## Verify the status of UFW and SSH

	$ sudo ufw status
	$ sudo service ssh status

or

	$ sudo systemctl status ufw
	$ sudo systemctl status sshd

## check the OS

	$ dpkg --version

## Users and groups

### Create a user

Check all the local users:

	$ cut -d: -f1 /etc/passwd

Create the user:

	$ sudo adduser <username>

Verify whether user was successfully created:

	$ getent passwd <username>

## Check password rules

To check if password rules apply to a username:

	$ sudo chage -l <username>

Open the following files to show the modifications implying the password policy:

	$ sudo nano /etc/sudoers
	$ sudo nano /etc/login.defs
	$ sudo nano /etc/pam.d/common-password

Change the password attributed to your user:

	$ sudo passwd <username>

### Create a group

	$ sudo groupadd user42
	$ sudo groupadd evaluating

Check if the group is created:

	$ getent group <group_name>

### Assign the user to group

Assign a user into the “evaluating” group:

	$ sudo usermod -aG user42 <username>
	$ sudo usermod -aG evaluating <username>

or

	$ sudo adduser <username> user42
	$ sudo adduser <username> evaluating

Check if the user is in a group:

	$ getent group user42
	$ getent group evaluating

Check to which groups a user account belongs:

`$ groups <username>` -> To check to which groups an user account belongs

To delete a user from a group:

	$ sudo deluser <username> <group_name>

To delete a group:

	$ sudo groupdel <group_name>

## Changing a hostname

Check the current hostname:

	$ hostnamectl

You can change it directly on the command line:

	$ hostnamectl set-hostname <new_hostname>

or modify the /etc/hosts file:

	$ sudo nano /etc/hosts

and replace the <old_hostname> with the <new_hostname>:

	127.0.0.1       localhost
	127.0.0.1       new_hostname

Reboot to actualize the changes:

	$ sudo reboot

## Showing the partitions of the machine:

	$ lsblk

## Verifying the sudo program status

	nano /var/log/sudo/sudo.log

## Creating and deleting a ufw rule

	$ sudo ufw allow 8080
	$ sudo ufw status
	$ sudo ufw delete allow 8080

## Connecting to the VM via an SSH connection

Find your IP address:

	$ ip a

Connect yourself to the port 4242:

	$ ssh <username@IP_address> -p 4242

	$ exit

Try to connect as root via the SSH connection:

	$ ssh root@<IP_address> -p 4242

## The script monitoring.sh

	nano /usr/local/bin/monitoring.sh

Here you may insert your /path/to/monitoring.sh.

## Starting the servers

### Running Lighttpd

First, check that your configuration is ok:

	$ sudo lighttpd -tt -f /etc/lighttpd/lighttpd.conf

Now start the server for testing:

`$ sudo lighttpd -D -f /etc/lighttpd/lighttpd.conf` -> The Lighttpd server is on, but the daemon is off

Enable the daemon:

	# /etc/init.d/lighttpd start

Wordpress is connected to the port 3000, so I type <IP address>:3000 on a browser to find my site.

Stop it:

	# /etc/init.d/lighttpd stop

### Running Icecast

Start the server with the following command:

	$ sudo icecast2 -c /etc/icecast2/icecast.xml

The Icecast server is connected to the port 8000, so I type <IP address>:8000 into a browser to find it.

The daemon is not on in this case.

### Sources:
* Wikipedia, <https://en.wikipedia.org/wiki/Virtualization>;
* Ayoub01, <https://github.com/ayoub0x1/born2beroot>;
* Computer Hope, <https://www.computerhope.com/unix/aptitude.htm>;
* EducBa, <https://www.educba.com/centos-vs-debian>;
* AskUbuntu, <https://askubuntu.com/questions/187888/what-is-the-correct-way-to-completely-remove-an-application>;
* Pascal Wolff;
* GuillaumeOz, <https://github.com/GuillaumeOz/Born2beroot>;
* Baigalaa, <https://baigal.medium.com/born2beroot-e6e26dfb50ac>.