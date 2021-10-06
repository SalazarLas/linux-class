yum install -y httpd

systemctl start httpd.service

firewall-cmd --add-port 80/tcp --permanent
firewall-cmd --add-port 443/tcp --permanent

firewall-cmd --reload

yum install -y php php-mysql

systemctl restart httpd.service

yum install -y php-fpm

cd /var/www/html/
echo '<?php phpinfo(); ?>' > index.php

yum install -y mariadb-server mariadb

systemctl start mariadb

echo -e "\ny\nlaslas\nlaslas\ny\ny\ny\ny\n" | mysql_secure_installation

systemctl enable mariadb.service

yum install -y rsync