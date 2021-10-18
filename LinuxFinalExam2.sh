#!/bin/bash

echo ""
echo ""
echo "###########################"
echo "#                         #"
echo "# Creating backups folder #"
echo "#                         #"
echo "###########################"
echo ""
cd /opt/
mkdir backups

echo ""
echo ""
echo "##########################################"
echo "#                                        #"
echo "# Checking if backups folder is created  #"
echo "#                                        #"
echo "##########################################"
echo ""
ls | grep backups

echo ""
echo ""
echo "###################################"
echo "#                                 #"
echo "# Exports the wordpress database  #"
echo "#                                 #"
echo "###################################"
echo ""
cd /opt/backups
mysqldump -u root -plaslas wordpress > wordpress_101821.sql

echo ""
echo ""
echo "############################################"
echo "#                                          #"
echo "# Checking if wordpress backup is created  #"
echo "#                                          #"
echo "############################################"
echo ""
ls | grep wordpress

echo ""
echo ""
echo "#################################"
echo "#                               #"
echo "# Compressing the backup to gz  #"
echo "#                               #"
echo "#################################"
echo ""
gzip wordpress_101821.sql

echo ""
echo ""
echo "#######################################################"
echo "#                                                     #"
echo "# Checking if compressed wordpress backup is created  #"
echo "#                                                     #"
echo "#######################################################"
echo ""
ls | grep wordpress