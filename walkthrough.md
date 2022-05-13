# Born2BeRoot, or creating and configuring a virtual machine with VirtualBox

## Table of Contents
- [Born2BeRoot, or creating and configuring a virtual machine with VirtualBox](#born2beroot-or-creating-and-configuring-a-virtual-machine-with-virtualbox)
	- [Table of Contents](#table-of-contents)
	- [STEP 1 - Installation of VirtualBox and VM settings](#step-1---installation-of-virtualbox-and-vm-settings)
	- [STEP 2 - Installation](#step-2---installation)
		- [Substep 2.1 - Partition setup](#substep-21---partition-setup)
			- [Subsubstep 2.1.1 - The basic part:](#subsubstep-211---the-basic-part)
			- [Subsubstep 2.1.2 - The bonus part:](#subsubstep-212---the-bonus-part)
	- [STEP 3 - Configure your machine](#step-3---configure-your-machine)
		- [Substep 3.1 - Installing sudo and adding user in groups](#substep-31---installing-sudo-and-adding-user-in-groups)
			- [Subsubstep 3.1.1 - Installing a text editor](#subsubstep-311---installing-a-text-editor)
		- [Substep 3.2 - Installing SSH](#substep-32---installing-ssh)
		- [Substep 3.3 - Installing UFW (Uncomplicated Firewall)](#substep-33---installing-ufw-uncomplicated-firewall)
		- [Substep 3.4 - Configuring the sudo powers](#substep-34---configuring-the-sudo-powers)
		- [Substep 3.5 - Setting up a strong password policy](#substep-35---setting-up-a-strong-password-policy)
	- [STEP 4 - Network adapter configuration](#step-4---network-adapter-configuration)
	- [Step 5 Installing tools](#step-5-installing-tools)
		- [Substep 5.1: Installing git](#substep-51-installing-git)
		- [Substep 5.2: Installing wget](#substep-52-installing-wget)
	- [STEP 6 - Configuring Cron Jobs](#step-6---configuring-cron-jobs)
	- [Step 7 - Installing Lighttpd, MariaDB, PHP and WordPress](#step-7---installing-lighttpd-mariadb-php-and-wordpress)
		- [Substep 7.1 - Installing Lighttpd](#substep-71---installing-lighttpd)
		- [Substep 7.2: Installing and Configuring MariaDB](#substep-72-installing-and-configuring-mariadb)
		- [Substep 7.3: Installing PHP](#substep-73-installing-php)
		- [Substep 7.4: Configuring Lighttpd](#substep-74-configuring-lighttpd)
	- [Step 8 - Installing and configuring Icecast](#step-8---installing-and-configuring-icecast)
	- [Step 9 - Getting the signature file of your machine (for MacOS users)](#step-9---getting-the-signature-file-of-your-machine-for-macos-users)
	- [Conclusion](#conclusion)
			- [Useful commands:](#useful-commands)
			- [Tips:](#tips)

## STEP 1 - Installation of VirtualBox and VM settings

You may find the the last version of VirtualBox at <https://www.virtualbox.org/wiki/Downloads>.
Follow the instructions provided to install and configurate your virtual machine.

Since you can't place your virtual disk in your user folder, you should put it in the goinfre folder of your machine instead.
Note that the goinfre folder is connected to the Mac, so you won't find your machine if you log in into another Mac.

The latest stable version of Debian at this day is the Debian GNU/Linux 11.3 version (released on March the 26th 2022), available on <https://www.debian.org/>. For more information on the latest releases, consult: <https://www.debian.org/releases>.

Linux, Debian 64-bit -> 1gb -> create vdf -> VDI -> Dynamically allocated -> 8gb

Settings -> storage -> IDE -> cd -> debian-xx-x-x-amd64-netinst.iso

Please note that the .iso image disk may be considered as a compressed folder by your operating system. In that case you mustn't unzip it.

It may be interesting to give a look at the OpenClassrooms lesson about virtualization, available here: <https://openclassrooms.com/fr/courses/7170491-initiez-vous-a-linux/7252071-installez-linux-ubuntu>, and to the French documentation of Ubuntu about it: <https://doc.ubuntu-fr.org/virtualbox>.

## STEP 2 - Installation  

Install (Not Graphical install)
Choose language (English)

Territory or area: Choose yours. United States, American English keyboard layout.

Hostname: yourintralogin42 -> Domain name: leave empty ->
-> Root password: qwerty123(!); Re-enter. Full name: Your full name.
Real/intra/else, doesn't matter. Username: your_intra_login ->
Password: zxc1337 (for example) -> Time zone: Your time zone(yes).

### Substep 2.1 - Partition setup

You can follow the step-to-step video-tutorial by Youssef Ossama here: <https://www.youtube.com/watch?v=OQEdjt38ZJA>

#### Subsubstep 2.1.1 - The basic part:
Partition method: Guided - use entire disk and set up encrypted LVM -> SCSIX (0,0,0) (sda) - 8.6 GB ATA VBOX HARDDISK -> separate /home partition -> yes.
Enter encryption passphrase twice -> 8.1G or just max ->
Finish partitioning and write changes to disk -> yes.

#### Subsubstep 2.1.2 - The bonus part:  

Partition method: Manual -> SCSIX (0,0,0) (sda) -> 8.6 GB ATA HARDDISK -> yes -> pri/log 8.6 GB FREE SPACE -> Create a new partition (CRANP next) -> 500M -> Primary -> Beginning -> Mount point -> Boot -> Done setting up the partition(DSUP)
-> pri/log -> CRANP -> 8.1GB or "max" -> Logical -> mount point -> Do not mount it -> DSUP -> Configure encrypted volumes -> Yes -> Create encrypted volumes -> /dev/sda5 (press space to choose it) -> DSUTP -> Finish -> yes.

	"A mount point is a directory or file at which a new file system, directory, or file is made accessible. To mount a file system or a directory, the mount point must be a directory; and to mount a file, the mount point must be a file." <https://www.ibm.com/docs/en/aix/7.1?topic=mounting-mount-points>

For further information on partitioning, consult: <https://help.ubuntu.com/community/DiskSpace>.

Enter encryption passphrase twice -> Configure the Logical Volume Manager -> yes -> Create volume group -> LVMGroup ->
-> press pace on /dev/mapper/sda5_crypt, continue ->
-> Create logical volume(CLV next) -> LVMGroup (LVMG next) -> root -> 2G
CLV -> LVMG -> swap -> 1G
CLV -> LVMG -> home -> 1G
CLV -> LVMG -> var -> 1G
CLV -> LVMG -> srv -> 1G
CLV -> LVMG -> tmp -> 1G
CLV -> LVMG -> var-log -> all disk space that left -> Finish

Now you see "Partition disks" window and a lot of LVM VG LVMGroup LV ...
Go to first #1 998.2 MB (under home, <volumename> #1 for next steps) ->
-> Use as (UA next): -> EXT4 jfl -> Mount point: (MP next) -> /home ->
-> Done setting up the partition (yep, DSUP)
root #1 -> UA -> ext4 -> MU -> / - the root fs -> DSUP
srv #1 -> UA -> ext4 -> MU -> /srv -> DSUP
swap #1 -> UA -> swap area -> DSUP
tmp #1 -> UA -> ext4 -> MU -> /tmp -> DSUP
var #1 -> UA -> ext4 -> MU -> /var -> DSUP
var-log #1 -> UA -> ext4 -> MU -> Enter manually -> /var/log -> DSUP
Scroll below -> Finish partitioning and write changes to disk -> yes
Installation will begin.

Scan another CD or DVD? -> no
Debian archive mirror country -> your nearest mirror -> deb.debian.org (doesn't matter) -> leave proxy info field empty and proceed.

Participate in the package usage survey? -> NO!

Soft seclection: remove SSH server & standard system utilities with space (again)
GRUB - YES! -> /dev/sda
Installation completed -> continue

The virtual machine is ready for use.

## STEP 3 - Configure your machine

Enter your LVM encryption passphrase, log in into your user. GL HF.
Now we are going to install the necessary softwares and configure them.

### Substep 3.1 - Installing sudo and adding user in groups

For information about the sudo command, see eval.md.

1) `su -` -> insert the root password.
2) `$ adduser <your_username> sudo` (yep, you should be in root)
3) `su <your_username>` -> to log in with <your_username>.
4) `$ sudo -v` -> It updates the user's cached credentials, authenticating the user if necessary (man sudo).
5) `$ sudo addgroup user42`
6) `$ sudo adduser <your_username> user42`
7) `$ sudo apt update`

You may check whether the user has been successfully added to sudo group by typing the following command on the command line:

	$ getent group sudo

or

	$ getent group <your_username>

#### Subsubstep 3.1.1 - Installing a text editor

You may here choose to install the text editor of yoour choice. I personally chose Nano, but you may choose Vim if you prefer.

	$ sudo apt-get install vim

Nano appears to be already installed.

### Substep 3.2 - Installing SSH

1) `$ sudo apt install openssh-server`
You may verify if the program has been correctly installed by typing:
`$ dpkg -l | grep ssh`
2) `$ sudo nano /etc/ssh/sshd_config` -> change line "#Port 22" to "Port 4242" and "#PermitRootLogin prohibit-password" to "PermitRootLogin no" -> save and exit.
3) `$ sudo service ssh status`. It should be active. You may also check ssh status via:
`$ sudo systemctl status ssh`

Note that the sudo command gives access to information which would not be provided in its absence.

### Substep 3.3 - Installing UFW (Uncomplicated Firewall)

1) `$ sudo apt-get install ufw`
2) `$ sudo ufw enable`
3) `$ sudo ufw allow ssh` -> To configure the rules
4) `$ sudo ufw allow 4242` -> To configure the port rule
5) `$ sudo ufw status` -> To check whether the port rule has been added.
The firewall should be active with the ports 4242 and 4242(v6) allowed (from anywhere).

### Substep 3.4 - Configuring the sudo powers

Open the file `sudoers`:

	$ sudo nano /etc/sudoers

or

	$ sudo visudo

Add the following line in the file:

	your_username    ALL=(ALL) ALL

For authentication, the use of the sudo command has to be limited to 3 attempts in the event of an incorrect password:

	Defaults    passwd_tries=3

Add a wrong password warning message:

	Defaults   badpass_message="Password is wrong, please try again!"

Each action log file has to be saved in the /var/log/sudo/ folder. If there is no “/var/log/sudo” folder, create the sudo folder inside of “/var/log”:

	Defaults	logfile="/var/log/sudo/sudo.log"
	Defaults	log_input,log_output

Set tty as required.

	Defaults   requiretty

"When requiretty is set, sudo must be run from a logged-in terminal session (a tty). This prevents sudo from being used from daemons or other detached processes like cronjobs or webserver plugins. It also means you can't run it directly from an ssh call without setting up a terminal session.
This can prevent certain kinds of escalation attacks. For example, if I have a way to modify the crontab for a user who has NOPASSWD sudo permissions, I could use that to kick off a job as root." (Rob Napier, <https://stackoverflow.com/questions/67985925/why-would-i-want-to-require-a-tty-for-sudo-whats-the-security-benefit-of-requi>)

For security reasons, the paths that can be used by sudo must be restricted. As, for instance: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

	Defaults   secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
(It is already the case)

### Substep 3.5 - Setting up a strong password policy

1) `$ sudo nano /etc/login.defs`
2) replace the following lines like shown above:

	`PASS_MAX_DAYS 99999`  -> `PASS_MAX_DAYS    30`
	`PASS_MIN_DAYS 0`      -> `PASS_MIN_DAYS    2`

`PASS_WARN_AGE` is set to 7 by default.

3) `$ sudo apt install libpam-pwquality`
4) `$ sudo nano /etc/pam.d/common-password`
5) At the end of the line: `"password requisite pam_pwquality.so retry=3` add the following parameters:

		minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root use_authtok

Pour info:

* retry=N - Maximum number of retries to change password. The default for this parameter is 1.
* minlen=N - The minimum acceptable size for the new password (plus one if credits are not disabled which is the default). In addition to the number of characters in the new password, credit (of +1 in length) is given for each different kind of character (other, upper, lower and digit). The default value is 9.
* lcredit=N - Define the maximum credit for containing lowercase letters in the password. Default value is 1.
* ucredit=N - Define the maximum number for containing uppercase letters in the password. Default value is 1.
* dcredit=N - Define the maximum credit for containing digits in the password. Default value is 1.
* ocredit=N - Define the maximum credit for containing other characters in the password. Default value is 1.
* difok=N - Define the number of characters that must be different from the previous password.
* reject_username - Restrict the users to use their name as password.
* enforce_for_root - The module will return error on failed check even if the user changing the password is root. This option is off by default which means that just the message about the failed check is printed but root can change the password anyway.
* use_authtok - This argument is used to force the module to not prompt the user for a new password but use the one provided by the previously stacked password module.

Your line should look as follows:

		password requisite pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root

Now you have to change all your passwords according to your new password policy:

* `$ passwd`        <- change user password
* `$ sudo passwd`   <- change root password

Fo further information on the password policy, consult the man page for `pam_pwquality`.

## STEP 4 - Network adapter configuration

You may not be able to connect to your VM via SSH with standard settings in
VirtualBox. There's a way to fix it!

1) Turn off your VM.
2) Go to your VM settings in VirtualBox.
3) Network -> Bridged connection.
4) In your host (physical) machine open Terminal and run
`ssh <vmusername>@localhost -p 4242`

Now you can control your virtual machine from the host terminal.

## Step 5 Installing tools

To check for updates for the packages installed in our system, we use the commands:

	$ sudo apt-get update -y
	$ sudo apt-get upgrade -y

`update` is used to resynchronize the package index files from their sources. The indexes of available packages are fetched from the location(s) specified in /etc/apt/sources.list. For example, when using a Debian archive, this command retrieves and scans the Packages.gz files, so that information about new and updated packages is available. An `update` should always be performed before an `upgrade` or `dist-upgrade`.
`upgrade` is used to install the newest versions of all packages currently installed on the system from the sources enumerated in /etc/apt/sources.list. Packages currently installed with new versions available are retrieved and upgraded.
The `-y` flag implies an automatic yes to prompts; it assumes "yes" as answer to all prompts and run non-interactively. (From the man page of `apt-get`).

### Substep 5.1: Installing git

	$ sudo apt-get install git -y

Check git version:

	$ git --version

### Substep 5.2: Installing wget

wget is a free and open source tool for downloading files directly from web repositories.

	$ sudo apt-get install wget

## STEP 6 - Configuring Cron Jobs

All you need to do now, is to configure the script which will show up on all of your terminal windows every ten minutes, the monitoring.sh, that I put in `/usr/local/bin/`. It's important to place it in a folder which will be accessible by every user, since Cron will try to run it (since we will ask it to) no matter which user has logged in.

Why, then, in the /usr/local/bin/ path folder?
/usr was the default conventional location for users' home directories before 1988, when segregating home directories was considered a good management policy. Also, files in the /usr/ path were files that didn't need to be available until the system was booted up far enough to support normal interactive use.
Files under /usr/local are supposed to be particular to that single system. Files that are in any way generic should live elsewhere.
/bin, short for "binary," in this context means "a file that is not plain text." Most such files are executables on a Unix box, so these two terms have become synonymous in some circles. (From Warren Young, <https://unix.stackexchange.com/questions/4186/what-is-usr-local-bin>)

The monitoring.sh is a shell script, 

	[a] shell script is a computer program designed to be run by the Unix shell, a command-line interpreter.[1] The various dialects of shell scripts are considered to be scripting languages. Typical operations performed by shell scripts include file manipulation, program execution, and printing text. A script which sets up the environment, runs the program, and does any necessary cleanup or logging, is called a wrapper. (From <https://en.wikipedia.org/wiki/Shell_script>)

To find some of the information you need, it is necessary for you to install net-tools.

	$ sudo apt install net-tools

Let's now configure crontab.
To add the rule allowing the script to execute without sudo password, open the sudoers file:

	$ sudo visudo

and add the following line under the line starting with `%sudo`:

	your_username ALL=(root) NOPASSWD: /usr/local/bin/monitoring.sh

You need to configure Cron as root by executing the following line:

	sudo crontab -u root -e

What's the difference between `crontab -e` and `sudo crontab -e`?
  	
	The difference is that with `sudo crontab -e` the commands are scheduled with root user's credentials. So that the commands in the sudo's cron table are executed as root user.
	With` crontab -e`, the commands are scheduled with the regular user who is logged in.

Where should I put my cron command, should it be in sudo or without the sudo?

	Well, the answer to this depends on the type of command you want to run. If the command required sudo access then sudo crontab -e should be used. Else if the cron command doesn't require any special permission then use crontab -e. (From Santosh A, <https://stackoverflow.com/questions/43237488/linux-difference-between-sudo-crontab-e-and-just-crontab-e>)

To schedule a shell script to run every 10 minutes, add the following line at the end of the file:

	*/10 * * * * /usr/local/bin/monitoring.sh

Note: you can add the `wall` command to the cron, as in the following example, or directly on the script, as I did:

	*/10 * * * * /usr/local/bin/monitoring.sh | wall

Cron generally requires that commands are terminated with a new line. Edit your crontab; go to the end of the line which contains the last command and insert a new line (press enter).

You may check root's scheduled cron jobs with the following line:

	$ sudo crontab -u root -l

For issues that may arise during the configuration of crontab, consult the following forum page:
* <https://askubuntu.com/questions/23009/why-crontab-scripts-are-not-working>,
* <https://serverfault.com/questions/449651/why-is-my-crontab-not-working-and-how-can-i-troubleshoot-it>.

Consult my monitoring.sh if you're curious about how you may implement it. However, I recommend to try to do it on your own.

## Step 7 - Installing Lighttpd, MariaDB, PHP and WordPress

### Substep 7.1 - Installing Lighttpd

	$ sudo apt install lighttpd -y

To verify whether lighttpd has been successfully installed:

	$ dpkg -l | grep lighttpd

Now let's allow incoming connections using Port 80:

	$ sudo ufw allow 80

### Substep 7.2: Installing and Configuring MariaDB

To install mariadb-server:

	$ sudo apt install mariadb-server -y

To verify whether mariadb-server has been successfully installed:

	$ dpkg -l | grep mariadb-server

Start the interactive script to remove insecure default settings:

	$ sudo mysql_secure_installation

	Enter current password for root (enter for none): #Just press Enter (do not confuse database root with system root)
	Set root password? [Y/n] n
	Remove anonymous users? [Y/n] Y
	Disallow root login remotely? [Y/n] Y
	Remove test database and access to it? [Y/n] Y
	Reload privilege tables now? [Y/n] Y

Now, log in to the MariaDB console.

	$ sudo mariadb

Your log will appear as follows:

	MariaDB [(none)]>

Create a new database:

	MariaDB [(none)]> CREATE DATABASE <database-name>;

Create a new database user and grant them full privileges on the newly-created database:

	MariaDB [(none)]> GRANT ALL ON <database-name>.* TO '<username-2>'@'localhost' IDENTIFIED BY '<password-2>' WITH GRANT OPTION;

Flush the privileges:

	MariaDB [(none)]> FLUSH PRIVILEGES;

Exit the MariaDB shell:

	MariaDB [(none)]> exit

Verify whether the database user has been successfully created by logging in to the MariaDB console.

	$ mariadb -u <username-2> -p
	Enter password: <password-2>
	MariaDB [(none)]>

To have a confirmation of the creation of the database user access rights:

	MariaDB [(none)]> SHOW DATABASES;
	+--------------------+
	| Database           |
	+--------------------+
	| <database-name>    |
	| information_schema |
	+--------------------+

Exit the MariaDB shell via `exit`.

### Substep 7.3: Installing PHP

	$ sudo apt install php-cgi php-mysql -y
	$ dpkg -l | grep php

To download WordPress to /var/www/html:

	$ sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html

To extract the downloaded content you have to navigate to the folder where you download it, to the /var/www/html/ folder, or once you'll have extracted it, it will appear in your current position.

	$ cd /var/www/html/
	$ sudo tar -xzvf /var/www/html/latest.tar.gz

Remove the tarball:

	$ sudo rm /var/www/html/latest.tar.gz

Copy content of /var/www/html/wordpress to /var/www/html:

	$ sudo cp -r wordpress/* ./

or

	$ sudo cp -r /var/www/html/wordpress/* /var/www/html

Remove /var/www/html/wordpress:

	$ sudo rm -rf /var/www/html/wordpress

Create WordPress configuration file from its sample:

	$ sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

Configure WordPress to reference the previously created MariaDB database and user:

	$ sudo nano /var/www/html/wp-config.php

Replace the lines below

	23 define( 'DB_NAME', 'database_name_here' );^M
	26 define( 'DB_USER', 'username_here' );^M
	29 define( 'DB_PASSWORD', 'password_here' );^M

with:

	23 define( 'DB_NAME', '<database-name>' );^M
	26 define( 'DB_USER', '<username-2>' );^M
	29 define( 'DB_PASSWORD', '<password-2>' );^M

### Substep 7.4: Configuring Lighttpd

Enable lighttpd modules as follows:

	$ sudo lighty-enable-mod fastcgi
	$ sudo lighty-enable-mod fastcgi-php
	$ sudo service lighttpd force-reload

Personally, I found it useful to follow the tutorial pages for the installation and configuration of an Apache2 server at first, and only later for a lighttpd server)!

* <https://www.it-connect.fr/installer-un-serveur-lamp-linux-apache-mariadb-php-sous-debian-11>,
* <https://www.it-connect.fr/installation-de-wordpress-sous-linux>.

Remember that the official documentation is always the most reliable source of information.
You may find complementary material on the Lighttpd official website and on the official Ubuntu French community documentation:

* <https://redmine.lighttpd.net/projects/lighttpd/wiki/TutorialConfiguration>,
* <https://doc.ubuntu-fr.org/lighttpd>.

## Step 8 - Installing and configuring Icecast

I decided to install Icecast, a streaming media (audio/video) server distributed under the GNU license.
It can be used to create an Internet radio station a privately running jukebox, or a podcast, and it's very versatile since it supports many different types of audio and video files.

	sudo apt-get install icecast2

For a tutorial for configuring Icecast, please refer to the official documentation pages of Icecast:
* <https://www.icecast.org/docs>.

## Step 9 - Getting the signature file of your machine (for MacOS users)

	shasum <name_of_your_machine.vdi>

Type the command in the MacOS terminal and then copy and paste the code you get on a file called signature.txt that you will put at the root of your repository.
Remember to take a snapshot of your machine to use during the evaluation, so that you will be able to use the precited command on your machine to demonstrate you didn't modify it before the examination.

## Conclusion

!IMPORTANT: Don't forget to make a snapshot of your VM (actually a simple copy-paste action on the .vdi file may be sufficient) before the evaluation starts!

Now all you need to do is to prepare for the evaluation. You may find some information in my eval.md file.

#### Useful commands:
* `$ apt-get update -y` & `$ apt-get upgrade -y` to update all the softwares installed in your virtual machine;
* `ip a` to find the ip address of your machine;
* `systemctl status <program_name>` to check the working status of a program;
* `systemctl restart <program_name>` to restart a program;
* `systemctl reboot` to reboot the virtual machine;
* `sudo apt-cache search <program_name>` to find a software in Debian;
* `sudo apt-get install <program_name>` to install a software.
There are various commands to remove a package:
* `sudo apt-get remove <package_name>` which removes the binaries, but not the configuration or data files of the package, nor its dependencies.
* `apt-get purge <package_name>` or `apt-get remove --purge <package_name>` which removes everything regarding the package, but not the dependencies installed with it. It does not remove configuration or data files residing in users home directories, usually in hidden folders there. There is no easy way to get those removed as well.
* `apt-get autoremove` removing orphaned packages, i.e. installed packages that used to be installed as an dependency, but aren't any longer. Use this after removing a package which had installed dependencies you're no longer interested in.

#### Tips:
* If you have the following error when you reboot your VM, change the Display settings in your VirtualBox settings, as explained here: https://unix.stackexchange.com/questions/502540/why-does-drmvmw-host-log-vmwgfx-error-failed-to-send-host-log-message-sh.

	$ drm:vmw_host_log *ERROR* Failed to send host log message.

I thank ayoub0x1 <https://github.com/ayoub0x1/born2beroot>, HEADLIGHTER <https://github.com/HEADLIGHTER/Born2BeRoot-42>, GuillaumeOz <https://github.com/GuillaumeOz/Born2beroot> and Baigalaa <https://baigal.medium.com/born2beroot-e6e26dfb50ac> to the work of whom this walkthrough is freely inspired.
Finally, I'd like to thank FdB <https://github.com/bcheronn> for his wise pieces of advice support.

Other sources:
* OSTechNix, <https://ostechnix.com/force-users-use-strong-passwords-debian-ubuntu>.

For useful tips about the markdown language, see <https://wordpress.com/support/markdown-quick-reference>.