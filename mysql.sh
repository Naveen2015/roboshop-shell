script=$(realpath $0)
script_path=$(dirname $script)
source  ${script_path}/common.sh
mysql_root_password=$1

if [ -z "$mysql_root_password" ]
then
  echo Input MySQL Root Password Missing
  exit 1
  fi
func_print_heading "Installing mysql"
dnf module disable mysql -y
func_print_heading "copying my sql repo file to yum repos"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo
func_stat_check $?
dnf install mysql-community-server -y
func_stat_check $?


func_print_heading "staring mysql"
systemctl enable mysqld
systemctl restart mysqld
func_stat_check $?

func_print_heading "Reset mysql password"
mysql_secure_installation --set-root-pass $mysql_root_password
func_stat_check $?



