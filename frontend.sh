script=$(realpath $0)
script_path=$(dirname $script)
source script_path/common.sh

func_print_heading "Installing Nginx"
dnf install nginx -y
func_stat_check $?
func_print_heading "copying conf to nginx config location"
cp ${script_path}/roboshop.conf /etc/nginx/default.d/roboshop.conf

func_print_heading "removing nginx default directory"
rm -rf /usr/share/nginx/html/*
func_print_heading "Downloading frontend code base"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
func_print_heading "unzip the content"

cd /usr/share/nginx/html
unzip /tmp/frontend.zip
func_print_heading "Starting nginx"
systemctl enable nginx
systemctl start nginx
systemctl restart nginx