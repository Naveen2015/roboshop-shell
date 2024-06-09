echo -e "\e[32m Installing mysql\e[0m"
dnf module disable mysql -y
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo
dnf install mysql-community-server -y

echo -e "\e[32m staring mysql \e[0m"
systemctl enable mysqld
systemctl restart mysqld
echo -e "\e[32m Reset mysql password \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1