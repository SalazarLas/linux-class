#!/bin/bash

echo ""
echo ""
echo "####################"
echo "#                  #"
echo "# Installing HTTPD #"
echo "#                  #"
echo "####################"
echo ""
yum install -y httpd

echo ""
echo ""
echo "##################"
echo "#                #"
echo "# Starting HTTPD #"
echo "#                #"
echo "##################"
echo ""
systemctl start httpd.service

echo ""
echo ""
echo "########################"
echo "#                      #"
echo "# Adding port 80 & 443 #"
echo "#                      #"
echo "########################"
echo ""
firewall-cmd --add-port 80/tcp --permanent
firewall-cmd --add-port 443/tcp --permanent
firewall-cmd --reload

echo ""
echo ""
echo "##############################"
echo "#                            #"
echo "# Installing php & php-mysql #"
echo "#                            #"
echo "##############################"
echo ""
yum install -y php php-mysql
systemctl restart httpd.service

echo ""
echo ""
echo "######################"
echo "#                    #"
echo "# Installing php-fpm #"
echo "#                    #"
echo "######################"
echo ""
yum install -y php-fpm

echo ""
echo ""
echo "##################################################"
echo "#                                                #"
echo "# Inserting <?php phpinfo(); ?> inside index.php #"
echo "#                                                #"
echo "##################################################"
echo ""
cd /var/www/html/
echo '<?php phpinfo(); ?>' > info.php

echo ""
echo ""
echo "#####################################"
echo "#                                   #"
echo "# Installing mariadb-server mariadb #"
echo "#                                   #"
echo "#####################################"
echo ""
yum install -y mariadb-server mariadb

echo ""
echo ""
echo "####################"
echo "#                  #"
echo "# Starting mariadb #"
echo "#                  #"
echo "####################"
echo ""
systemctl start mariadb

echo ""
echo ""
echo "####################################"
echo "#                                  #"
echo "# Running a simple security script #"
echo "#                                  #"
echo "####################################"
echo ""
echo -e "\ny\nlaslas\nlaslas\ny\ny\ny\ny\n" | mysql_secure_installation

echo ""
echo ""
echo "############################"
echo "#                          #"
echo "# Enabling mariadb.service #"
echo "#                          #"
echo "############################"
echo ""
systemctl enable mariadb.service

echo ""
echo ""
echo "####################"
echo "#                  #"
echo "# Installing rsync #"
echo "#                  #"
echo "####################"
echo ""
yum install -y rsync

echo ""
echo ""
echo "#############################################"
echo "#                                           #"
echo "# Creating a new DATABASE & USER under root #"
echo "#                                           #"
echo "#############################################"
echo ""
mysql -u root -plaslas << mydatabase

CREATE DATABASE wordpress;

CREATE USER wordpressuser@localhost IDENTIFIED BY 'hello';

GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY 'hello';

FLUSH PRIVILEGES;

mydatabase

echo ""
echo ""
echo "#####################"
echo "#                   #"
echo "# Installing php-gd #"
echo "#                   #"
echo "#####################"
echo ""
yum install -y php-gd
systemctl restart httpd

echo ""
echo ""
echo "###################"
echo "#                 #"
echo "# Installing wget #"
echo "#                 #"
echo "###################"
echo ""
yum install -y wget

echo ""
echo ""
echo "####################################################"
echo "#                                                  #"
echo "# Installing WordPress from the project’s website  #"
echo "#                                                  #"
echo "####################################################"
echo ""
cd /opt/
wget http://wordpress.org/latest.tar.gz

echo ""
echo ""
echo "##################"
echo "#                #"
echo "# Installing tar #"
echo "#                #"
echo "##################"
echo ""
yum install -y tar

echo ""
echo ""
echo "###############################"
echo "#                             #"
echo "# Downloading WordPress files #"
echo "#                             #"
echo "###############################"
echo ""
tar xzvf latest.tar.gz

echo ""
echo ""
echo "#############################################################"
echo "#                                                           #"
echo "# Transferring the unpacked files to Apache’s document root #"
echo "#                                                           #"
echo "#############################################################"
echo ""
cd /opt/
rsync -avP wordpress/ /var/www/html/

echo ""
echo ""
echo "######################################"
echo "#                                    #"
echo "# Creating uploads inside wp-content #"
echo "#                                    #"
echo "######################################"
echo ""
mkdir /var/www/html/wp-content/uploads

echo ""
echo ""
echo "#################################################"
echo "#                                               #"
echo "# Granting ownership to Apache’s user and group #"
echo "#                                               #"
echo "#################################################"
echo ""
chown -R apache:apache /var/www/html/*

echo ""
echo ""
echo "##################################################"
echo "#                                                #"
echo "# Copying the default configuration to wp-config #"
echo "#                                                #"
echo "##################################################"
echo ""
cd /var/www/html
cp wp-config-sample.php wp-config.php

echo ""
echo ""
echo "##########################################################"
echo "#                                                        #"
echo "# Modifying parameters to match the database information #"
echo "#                                                        #"
echo "##########################################################"
echo ""
cd /var/www/html/
sed -i 's/database_name_here/wordpress/g' wp-config.php

sed -i 's/username_here/wordpressuser/g' wp-config.php

sed -i 's/password_here/hello/g' wp-config.php

echo ""
echo ""
echo "#################################"
echo "#                               #"
echo "# Installing new version of PHP #"
echo "#                               #"
echo "#################################"
echo ""
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm

yum install -y yum-utils

yum-config-manager --enable remi-php56 

yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo

systemctl restart httpd

yum install -y sl 
yum install -y cowsay

sl 

cowsay Thankyou for Installing LAMP stack and WordPress
