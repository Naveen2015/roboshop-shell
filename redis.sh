script=$(realpath $0)
script_path=$(dirname $script)
source  ${script_path}/common.sh

func_print_heading "Configuring Redis and Installing"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
dnf module enable redis:remi-6.2 -y
dnf install redis -y
func_stat_check $?


func_print_heading "Changing the redis listen address"

sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis/redis.conf
func_stat_check $?

func_print_heading "starting redis service"
systemctl enable redis
systemctl start redis
func_stat_check $?
