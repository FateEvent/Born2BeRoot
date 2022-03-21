## STEP 1 - VM settings

You can't create your virtual disk in your user folder.
Use other -> goinfre/VirtualBox VMs/ folder as your machine folder instead.
Note that the goinfre folder is connected to the Mac, so you won't find your machine if you connect yourself to another Mac.

Linux, Debian 64-bit -> 1gb -> create vdf -> VDI -> Dynamically allocated -> 8gb

Settings -> storage -> IDE -> cd -> debian-xx-x-x-amd64-netinst.iso

## STEP 2 - Installation  

Install (Not Graphical install)
Choose language (English)

Territory or area: Choose yours. United States, American English keyboard layout.

Hostname: yourintralogin42 -> Domain name: leave empty ->
-> Root password: qwerty123(!); Re-enter. Full name: Your full name.
Real/intra/else, doesn't matter. Username: your_intra_login ->
Password: zxc1337 (for example) -> Time zone: Your time zone(yes).

### substep 2.1 - partition setup

#### For the basic part:
Partition method: Guided - use entire disk and set up encrypted LVM ->
-> SCSIX (0,0,0) (sda) - 8.6 GB ATA VBOX HARDDISK -> separate /home partition ->
-> yes. Wait.
Enter encryption passphrase twice -> 8.1G or just max ->
-> Finish partitioning and write changes to disk -> yes.

#### For the bonus part:  

Partition method: Manual -> SCSIX (0,0,0( (sda) -> 8.6 GB ATA HARDDISK ->
-> yes -> pri/log 8.6 GB FREE SPACE -> Create a new partition (CRANP next) ->
-> 500M -> Primary -> Beginning -> Mount point -> Boot ->
-> Done setting up the partition(DSUP) -> pri/log -> CRANP -> 8.1GB or "max"->
-> Logical -> mount point -> Do not mount it -> DSUP ->
-> Configure encrypted volumes -> Yes -> Create encrypted volumes ->
-> /dev/sda5 (press space to choose it) -> DSUTP -> Finish -> yes -> Wait.

Enter encryption passphrase twice -> Configure the Logical Volume Manager ->
-> yes -> Create volume groupe -> LVMGroup ->
-> press pace on /dev/mapper/sda5_crypt, continue ->
-> Create logical volume(CLV next) -> LVMGroup (LVMG next) -> root -> 2G
CLV -> LVMG -> swap -> 1G
CLV -> LVMG -> home -> 1G
CLV -> LVMG -> var -> 1G
CLV -> LVMG -> srv -> 1G
CLV -> LVMG -> tmp -> 1G
CLV -> LVMG -> var-log -> all disk space that left -> Finish

Now u see "[!!] Partition disks" window and a lot of LVM VG LVMGroup LV ...
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
Debian archive mirror country -> your nearest mirror or Russian Federation for
Moscow campus -> deb.debian.org (doesn't matter) ->
-> leave proxy info field empty and proceed.

Participate in the package usage survey? -> NO!

Soft seclection: remove SSH server & standard system utilities with space(again)
GRUB - YES! -> /dev/sda
Installation completed -> continue

The virtual machine is ready for use.

## STEP 3 - Configure your machine

Enter your LVM encryption passphrase, log in into your user. GL HF.
Now we are going to install the necessary softwares and configure them.

You may here choose to install the text editor of yoour choice. I personally chose Nano, but you may choose Vim if you prefer.

`$ apt-get update -y`
`$ apt-get upgrade -y`

and

`$ apt-get install vim`

or

`$ apt-get install nano`

### substep 3.1 - Installing sudo & adding user in groups

1) `su -` -> root password -> apt install sudo
2) `$ adduser <your_username> sudo` (yep, you should be in root)
3) `$ sudo reboot`, then log in again
4) `$ sudo -v` -> password
5) `$ sudo addgroup user42`
6) `$ sudo adduser <your_username> user42`
7) `$ sudo apt update`

You may check whether the user has been successfully added to sudo group by typing the following command on the command line:

`$ getent group sudo`

### substep 3.2 - Installing SSH

1) `$ sudo apt install openssh-server`
2) `$ sudo nano /etc/ssh/sshd_config` -> change line "#Port 22" to "Port 4242" and
"#PermitRootLogin prohibit-password" to "PermitRootLogin no" -> save and exit
3) `$ sudo nano /etc/ssh/ssh_config` -> change line "#Port 22" to "Port 4242"
4) `$ sudo service ssh status`. It's should be active.

### substep 3.3 - Installing UFW

1) `$ sudo apt install ufw`
2) `$ sudo ufw enable`
3) `$ sudo ufw allow 4242`
4) `$ sudo ufw status`
It should be active with the ports 4242 and 4242(v6) allowed (from anywhere)

### substep 3.4 - Configuring sudo

1) `$ sudo touch /etc/sudoers.d/sudoconfig`
2) `$ sudo mkdir /var/log/sudo` (for sudo log files, yes)
3) `$ sudo nano /etc/sudoers.d/sudoconfig` then write the following lines in our new file:

* Defaults      passwd_tries=3
* Defaults      badpass_message="Incorrect password" <- you can set your own message here
* Defaults      log_input,log_output                       
* Defaults      iolog_dir="/var/log/sudo"
* Defaults      requiretty
* Defaults      secure_path="that/long/paths/from/subject"

### substep 3.5 - Setting up a strong password policy

1) `$ sudo nano /etc/login.defs`
2) replace the following lines like shown above:

* `PASS_MAX_DAYS 99999  -> PASS_MAX_DAYS    30`
* `PASS_MIN_DAYS 0      -> PASS_MIN_DAYS    2`

`PASS_WARN_AGE` is set to 7 by default.

3) `sudo apt install libpam-pwquality`
4) `sudo nano /etc/pam.d/common-password`
5) At the end of the line: `"password requisite pam_pwquality.so retry=3` add the following parameters:

* `minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root`

Your line should look as follows:
`password requisite pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root`

6) Now you have to change all your passwords according to your new password
policy

* `$ passwd`        <- change user password
* `$ sudo passwd`   <- change root password

## STEP 4 - Network adapter configuration

You may not be able to connect to your VM via SSH with standard settings in
VirtualBox. There's a way to fix it!

1) Turn off your VM
2) Go to your VM settings in VirtualBox
3) Network -> Adapter 1 -> Advanced -> Port forwarding
4)Add new rule (little green button on right top side) and next parameters:

* Protocol       Host IP       Host Port       Guest IP       Guest Port
* TCP            127.0.0.1     4242            10.0.2.15      4242

6) In your host (physical) machine open Terminal and run
[ssh <vmusername>@localhost -p 4242]

Now you can control your virtual machine from the host terminal.

## STEP 5 - Configuring Cron Jobs

You need to configure cron as root by executing the following line:

`sudo crontab -u root -e`

To schedule a shell script to run every 10 minutes, add the following line at the end of the file:

`*/10 * * * * /path/to/monitoring.sh`

Note: you can add the `wall` command to the cron, as in the following example, or directly on the script, as I did:

`*/10 * * * * /path/to/monitoring.sh | wall`

You may check root's scheduled cron jobs with the following line:

`$ sudo crontab -u root -l`

Now all that you need to do is to configure the script which will show up on all of your terminal windows every ten minutes, the monitoring.sh.
To find some of the information you need, it is necessary for you to install net-tools.

* [$ sudo apt install net-tools]

## Step 6 - Installing Lighttpd, MariaDB, PHP and WordPress

### substep 6.1 - Installing Lighttpd

`$ sudo apt install lighttpd`

To verify whether lighttpd has been successfully installed:

`$ dpkg -l | grep lighttpd`

Now let's allow incoming connections using Port 80:

`$ sudo ufw allow 80`

### substep 6.2: Installing and Configuring MariaDB

To install mariadb-server:

`$ sudo apt install mariadb-server`

To verify whether mariadb-server has been successfully installed:

`$ dpkg -l | grep mariadb-server`

Start the interactive script to remove insecure default settings:

`$ sudo mysql_secure_installation`

``
Enter current password for root (enter for none): #Just press Enter (do not confuse database root with system root)
Set root password? [Y/n] n
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y
``

Now, log in to the MariaDB console.
`$ sudo mariadb`

Your log will appear as follows:
`MariaDB [(none)]>`

Create a new database:
`MariaDB [(none)]> CREATE DATABASE <database-name>;`

Create a new database user and grant them full privileges on the newly-created database.

`MariaDB [(none)]> GRANT ALL ON <database-name>.* TO '<username-2>'@'localhost' IDENTIFIED BY '<password-2>' WITH GRANT OPTION;`

Flush the privileges.

`MariaDB [(none)]> FLUSH PRIVILEGES;`

Exit the MariaDB shell.

`MariaDB [(none)]> exit`

Verify whether the database user has been successfully created by logging in to the MariaDB console.
``
$ mariadb -u <username-2> -p
Enter password: <password-2>
MariaDB [(none)]>
``

To have a confirmation of the creation of the database user access rights:
``
MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| <database-name>    |
| information_schema |
+--------------------+
``
Exit the MariaDB shell via `exit`.

### substep 6.3: Installing PHP

``
$ sudo apt install php-cgi php-mysql
$ dpkg -l | grep php
``

The `wget` command allows you to download files directly from a website.
To download WordPress to /var/www/html:
`$ sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html`

To extract downloaded content:
`$ sudo tar -xzvf /var/www/html/latest.tar.gz`

Remove tarball:
`$ sudo rm /var/www/html/latest.tar.gz`

Copy content of /var/www/html/wordpress to /var/www/html:
`$ sudo cp -r /var/www/html/wordpress/* /var/www/html`

Remove /var/www/html/wordpress:
`$ sudo rm -rf /var/www/html/wordpress`

Create WordPress configuration file from its sample:
`$ sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php`

Configure WordPress to reference the previously created MariaDB database & user:
`$ sudo vi /var/www/html/wp-config.php`

Replace the lines below
``
23 define( 'DB_NAME', 'database_name_here' );^M
26 define( 'DB_USER', 'username_here' );^M
29 define( 'DB_PASSWORD', 'password_here' );^M
``

with:

``
23 define( 'DB_NAME', '<database-name>' );^M
26 define( 'DB_USER', '<username-2>' );^M
29 define( 'DB_PASSWORD', '<password-2>' );^M
``

### Substep 6.4: Configuring Lighttpd

Enable lighttpd modules as follows:
``
$ sudo lighty-enable-mod fastcgi
$ sudo lighty-enable-mod fastcgi-php
$ sudo service lighttpd force-reload
``

Remember that the official documentation is always the most reliable source of information.
Personally, I followed the following tutorial pages and everything works just fine (I installed Apache2 at first, and only later lighttpd)!

* <https://www.it-connect.fr/installer-un-serveur-lamp-linux-apache-mariadb-php-sous-debian-11/>
* <https://www.it-connect.fr/installation-de-wordpress-sous-linux/>
* <https://redmine.lighttpd.net/projects/lighttpd/wiki/TutorialConfiguration>

## Conclusion

!IMPORTANT: Don't forget to make a clone or a snapshot of your VM before the evaluation starts!

Now all you need to do is to prepare for the evaluation. Don't forget to check the answers to the questions in my eval.md file.

#### useful commands:
`ip a` to find the ip address of your machine


I thank HEADLIGHTER <https://github.com/HEADLIGHTER/Born2BeRoot-42> and GuillaumeOz <https://github.com/GuillaumeOz/Born2beroot> to the work of whom this walkthrough is freely inspired.