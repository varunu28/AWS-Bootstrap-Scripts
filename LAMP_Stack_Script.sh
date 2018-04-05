#!/bin/bash
#The script creates an index.html which displays the instance id
sudo su
yum update -y
yum groupinstall -y "Web Server" 
yum groupinstall -y "MySQL Database" 
yum groupinstall -y "PHP Support" --skip-broken
service httpd start
chkconfig httpd on
groupadd www
usermod -a -G www ec2-user
chown -R root:www /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} +
find /var/www/ -type f -exec chmod 0664 {} +
val=$(curl http://169.254.169.254/latest/meta-data/instance-id)
echo "<h1>Instance id is: $val</h1>" > index.html
