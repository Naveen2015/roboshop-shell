script=$(realpath $0)
script_path=$(dirname $script)
source script_path/common.sh
mysql_root_password=$1

if [ -z "$mysql_root_password" ]
then
  echo Input MySQL Root Password Missing
  exit
  fi
func_print_heading "Installing mysql"
dnf module disable mysql -y
dnf install mysql-community-server -y
func_stat_check $?


func_print_heading "copying my sql repo file to yum repos"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo
func_stat_check $?

func_print_heading "Reset mysql password"
mysql_secure_installation --set-root-pass RoboShop@1
func_stat_check $?

func_print_heading "staring mysql"
systemctl enable mysqld
systemctl restart mysqld
func_stat_check $?

