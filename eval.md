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

AppArmor ("Application Armor") is a Linux kernel security module that allows the system administrator to restrict programs' capabilities with tailor-made, per-program profiles. Profiles can allow capabilities like network access, raw socket access, and the permission to read, write, or execute files on matching paths. It's what is called mandatory access control (MAC), a type of access control by which the operating system or database constrains the ability of a subject, a process, for example, to access or generally perform some sort of operation on an object, a file, a directory, a TCP/UDP port, etc. Subjects and objects each have a set of security attributes. Whenever a subject tries to accede to an object, their attributes are examined.
It exists, however, two ways in which profiles may work, a "complaint mode" and an "enforce mode". In the last case, the processes are restrained from performing restricted tasks, while in the first one, AppArmor allows applications to do these tasks, but creates a registry entry to display the complaint.
AppArmor is partly offered as an alternative to SELinux, which critics consider difficult for administrators to set up and maintain. Unlike SELinux, which is based on applying labels to files, AppArmor works with file paths.

### What is SELinux?

SELinux (Security-Enhanced Linux) is a security architecture for Linux systems that allows administrators to better control access to the system. This architecture was originally designed by the NSA, the national security agency of the United States, as a series of fixes for the Linux kernel based on the LSM (Linux Security Modules) framework.

### What is the difference between Apt and Aptitude?

In Debian-based OS distributions, the default package manager is dpkg. This tool allows us to install, remove and manage programs on our operating system. However, in most cases, these programs come with a list of dependencies that must be installed for the main program to function properly, and we have to install them manually. However, APT (Advanced Package Tool) may install all the necessary dependencies when installing a program. A single command thus allows us to install a software and all its packages.
In case we wanted to use a graphical interface, however, we would have to use Aptitude, the text-based front-end for the APT package management system. It allows the user to view the list of packages and to perform package management tasks such as installing, upgrading, and removing packages either from a visual interface or from the command-line.

### What's SSH?

SSH or Secure Shell is a remote administration protocol that allows users to control and modify their servers over the Internet thanks to an authentication mechanism. It provides a mechanism to authenticate a user remotely, transfer data from a client to a host, and return a response to the request made by the client.
SSH was created as an alternative to Telnet, which does not encrypt the transmissions. SSH, on the contrary, makes sure that all communications are encrypted.
To connect to a Linux terminal from a MacOS terminal via an SSH connection type:
`ssh {username}@{IP_host} -p {port}`

SSH uses three techniques to encrypt:

* Symmetric encryption: a method that uses the same secret key for both encryption and decryption of a message, for both the client and the host. Anyone who knows the password can access the message that has been transmitted;
* Asymmetric encryption: a method using two separate keys for encryption and decryption. These are known as the public key and the private key. Together, they form the public-private key pair.
* Hashing: hash functions are made in a way that they don't need to be decrypted. If a client has the correct input, they can create a cryptographic hash and SSH will check if both hashes are the same.

### How to implement UFW with SSH

UFW (Uncomplicated Firewall) is a software application responsible for ensuring that the system administrator can manage iptables in a simple way. Since it is very difficult to work with iptables, UFW provides us with an interface to modify the firewall of our device (netfilter) without compromising security. Once we have UFW installed, we can choose which ports we want to allow connections, and which ports we want to close. This will also be very useful with SSH, greatly improving all security related to communications between devices.

### Cron, wall and the useless thing

#### What's Cron?

Cron is a Linux task manager allowing us to execute commands at a certain time. We can automate some tasks just by telling cron what command we want to run at a specific time. For example, if we want to restart our server every day at 4:00 am, instead of having to wake up at that time, cron will do it for us.

#### The wall command

The `wall` command used by the root user to send a message to all users currently connected to the server. If the system administrator wishes to alert about a major server change, the root user could alert them with this command.

## Groups

### Create a group

    $ sudo groupadd user42
    $ sudo groupadd evaluating

Check if group created:

    $ getent group

### Create a user and assign them into group

Check all the local users:

    $ cut -d: -f1 /etc/passwd

Create the user:
`$ sudo adduser <your_username>`

Assign a user into the “evaluating” group:

    $ sudo usermod -aG user42 <your_username>
    $ sudo usermod -aG evaluating <your_username>

Check if the user is in a group:

    $ getent group user42
    $ getent group evaluating

Check to which groups a user account belongs:
`$ groups <username>` -> To check to which groups an user account belongs

To delete a user from a group:

    $ sudo deluser <username> <group_name>

To delete a group:

    $ sudo groupdel <group_name>

## Password rules

To check if password rules apply to a username:

    $ chage -l <username>

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

Reboot to actualize the change:

    $ sudo reboot

## Deleting a ufw rule

    $ sudo ufw status <number>
    $ sudo ufw delete <number>

## Getting the signature file of your machine (for MacOS users)

    shasum <name_of_your_machine.vdi>

Type the command in the MacOS terminal and then copy and paste the code you get on a file called signature.txt that you will put at the root of your repository.
Remember to take a snapshot of your machine to use during the evaluation, so that you will be able to use the precited command on your machine to demonstrate you didn't modify it before the examination.

### Sources:
* Wikipedia, <https://en.wikipedia.org/wiki/Virtualization>;
* Ayoub01, <https://github.com/ayoub0x1/born2beroot>;
* Computer Hope, <https://www.computerhope.com/unix/aptitude.htm>;
* AskUbuntu, <https://askubuntu.com/questions/187888/what-is-the-correct-way-to-completely-remove-an-application>;
* GuillaumeOz, <https://github.com/GuillaumeOz/Born2beroot>;
* Baigalaa, <https://baigal.medium.com/born2beroot-e6e26dfb50ac>.