script=$(realpath $0)
script_path=$(dirname $script)
source  ${script_path}/common.sh

func_print_heading "copying mongo repo file to yum repository"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
func_stat_check $?

func_print_heading "Installing MongoDB"
dnf install mongodb-org -y
func_stat_check $?

func_print_heading "update MongoDB Listen address"

sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf
func_stat_check $?

func_print_heading "Starting MongoDB"
systemctl enable mongod
systemctl restart mongod