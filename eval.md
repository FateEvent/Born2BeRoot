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

### A snapshot

A snapshot is a state of a virtual machine at an exact point in time. It allows users to restore a virtual machine's state at the time of the snapshot, effectively undoing any changes that occurred afterwards. This capability is useful as a backup technique, for example, prior to performing a risky operation.

Virtual machines frequently use virtual disks for their storage; a 10-gigabyte hard disk drive, for example, is simulated with a 10-gigabyte flat file. Any requests by the VM for a location on its physical disk are transparently translated into an operation on the corresponding file. Once such a translation layer is present, however, it is possible to intercept the operations and send them to different files, depending on various criteria. Every time a snapshot is taken, a new file is created, and used as an overlay for its predecessors. New data is written to the topmost overlay; reading existing data, however, needs the overlay hierarchy to be scanned, resulting in accessing the most recent version. Thus, the entire stack of snapshots is virtually a single coherent disk; in that sense, creating snapshots works similarly to the incremental backup technique.

Other components of a virtual machine can also be included in a snapshot, such as the contents of its random-access memory (RAM), BIOS settings, or its configuration settings. "Save state" feature in video game console emulators is an example of such snapshots.

Restoring a snapshot consists of discarding or disregarding all overlay layers that are added after that snapshot, and directing all new changes to a new overlay.

### What is AppArmor?

AppArmor ("Application Armor") is a Linux kernel security module that allows the system administrator to restrict programs' capabilities with tailor-made, per-program profiles. Profiles can allow capabilities like network access, raw socket access, and the permission to read, write, or execute files on matching paths. It's what is called mandatory access control (MAC), a type of access control by which the operating system or database constrains the ability of a subject, a process, for example, to access or generally perform some sort of operation on an object, a file, a directory, a TCP/UDP port, etc. Subjects and objects each have a set of security attributes, which are examined whenever a subject tries to accede to an object.
It exists, however, two ways in which profiles may work, in complain mode and in enforce mode. In the last case, the processes from performing restricted tasks. In complain-mode, AppArmor allows applications to do these tasks, but creates a registry entry to display the complaint.
AppArmor is offered in part as an alternative to SELinux, which critics consider difficult for administrators to set up and maintain. Unlike SELinux, which is based on applying labels to files, AppArmor works with file paths.


What is the difference between Apt and Aptitute?

In Debian-based OS distributions, the default package manager we can use is dpkg. This tool allows us to install, remove and manage programs on our operating system. However, in most cases, these programs come with a list of dependencies that must be installed for the main program to function properly. One option is to manually install these dependencies. However, APT (Advanced Package Tool), which is a tool that uses dpkg, can be used to install all the necessary dependencies when installing a program. So now we can install a useful program with a single command.
APT can work with different back-ends and fron-ends to make use of its services. One of them is apt-get, which allows us to install and remove packages. Along with apt-get, there are also many tools like apt-cache to manage programs. In this case, apt-get and apt-cache are used by apt. Thanks to apt we can install .deb programs easily and without worrying about dependencies. But in case we want to use a graphical interface, we will have to use aptitude. Aptitude also does better control of dependencies, allowing the user to choose between different dependencies when installing a program.
How to use SSH?

SSH or Secure Shell is a remote administration protocol that allows users to control and modify their servers over the Internet thanks to an authentication mechanism. Provides a mechanism to authenticate a user remotely, transfer data from the client to the host, and return a response to the request made by the client.
SSH was created as an alternative to Telnet, which does not encrypt the information that is sent. SSH uses encryption techniques to ensure that all client-to-host and host-to-client communications are done in encrypted form. One of the advantages of SSH is that a user using Linux or MacOS can use SSH on their server to communicate with it remotely through their computer's terminal. Once authenticated, that user will be able to use the terminal to work on the server.

The command used to connect to a server with ssh is:

ssh {username}@{IP_host} -p {port}

There are three different techniques that SSH uses to encrypt:

    Symmetric encryption: a method that uses the same secret key for both encryption and decryption of a message, for both the client and the host. Anyone who knows the password can access the message that has been transmitted.
    Asymmetric encryption: uses two separate keys for encryption and decryption. These are known as the public key and the private key. Together, they form the public-private key pair.
    Hashing: another form of cryptography used by SSH. Hash functions are made in a way that they don't need to be decrypted. If a client has the correct input, they can create a cryptographic hash and SSH will check if both hashes are the same.

How to implement UFW with SSH

UFW (Uncomplicated Firewall) is a software application responsible for ensuring that the system administrator can manage iptables in a simple way. Since it is very difficult to work with iptables, UFW provides us with an interface to modify the firewall of our device (netfilter) without compromising security. Once we have UFW installed, we can choose which ports we want to allow connections, and which ports we want to close. This will also be very useful with SSH, greatly improving all security related to communications between devices.
What is cron and what is wall?

Once we know a little more about how to build a server inside a Virtual Machine (remember that you also have to look in other pages apart from this README), we will see two commands that will be very helpful in case of being system administrators. These commands are:

    Cron: Linux task manager that allows us to execute commands at a certain time. We can automate some tasks just by telling cron what command we want to run at a specific time. For example, if we want to restart our server every day at 4:00 am, instead of having to wake up at that time, cron will do it for us.
    Wall: command used by the root user to send a message to all users currently connected to the server. If the system administrator wants to alert about a major server change that could cause users to log out, the root user could alert them with wall.


Sources: Wikipedia <https://en.wikipedia.org/wiki/Virtualization>, <https://github.com/ayoub0x1/born2beroot>

## Groups

### Create a group
``
$ sudo groupadd user42
$ sudo groupadd evaluating
``
Check if group created:
`$ getent group`

### Create a user and assign them into group

Check all the local users:
`$ cut -d: -f1 /etc/passwd`

Create the user:
`$ sudo adduser <your_username>`

Assign a user into the “evaluating” group:
``
$ sudo usermod -aG user42 <your_username>
$ sudo usermod -aG evaluating <your_username>
``

Check if the user is in a group:
``
$ getent group user42
$ getent group evaluating
``

Check to which groups a user account belongs:
`$ groups <username>` -> To check to which groups an user account belongs

To delete a user from a group:
`$ sudo deluser <username> <group_name>`

To delete a group:
`$ sudo groupdel <group_name>`

## Password rules

To check if password rules apply to a username:
`$ chage -l <username>`

## Changing a hostname

Check the current hostname:
`$ hostnamectl`

You can change it directly on the command line:
`$ hostnamectl set-hostname <new_hostname>`
or modify the /etc/hosts file:
`$ sudo nano /etc/hosts`
and replace the <old_hostname> with the <new_hostname>:
``
127.0.0.1       localhost
127.0.0.1       new_hostname
``

Reboot to actualize the change:
`$ sudo reboot`

## Deleting a ufw rule
``
$ sudo ufw status <number>
$ sudo ufw delete <number>
``

## Getting the signature file of your machine
`shasum <name_of_your_machine.vdi>`
Type the command in the MacOS terminal and then copy and paste the code you get on a file called signature.txt that you will push to the 42 repo.
Remember to take a snapshot of your machine to use during the evaluation, so that you will be able to use the precited command on your machine to demonstrate you didn-t modify it before the examination.