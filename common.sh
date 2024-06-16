  script=$(realpath $0)
  script_path=$(dirname $script)
  app_user=roboshop

  func_print_heading()
  {
      echo -e "\e[32m $1 \e[0m"
  }
  func_schema_setup()
  {
     if [ "$schema_setup" == "mongo" ]
      then
    func_print_heading "Copy MongoDB Repo file"
    cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
    func_print_heading "Installing MongoDB Client"
    dnf install mongodb-org-shell -y
    func_print_heading "Loading Schema"
    mongo --host mongod-dev.kruthikadevops.online	</app/schema/${component_name}.js
  fi
  }
  func_systemd()
  {
    func_print_heading "copy service file to systemd"
        cp ${script_path}/${component_name}.service /etc/systemd/system/${component_name}.service
    func_print_heading "start ${component_name} service"
        systemctl daemon-reload
        systemctl enable ${component_name}
        systemctl restart ${component_name}
        func_stat_check $?
  }
  func_nodejs()
  {
    func_print_heading "configuring and installing Nodejs"
    dnf module disable nodejs -y
    dnf module enable nodejs:18 -y
    dnf install nodejs -y
func_stat_check $?
    func_prereq



    func_print_heading "NPM install"

    npm install
    func_systemd

  func_schema_setup
  }
  func_prereq()
  {
    func_print_heading "Adding Application user"
    id ${app_user}
    if [ $? -ne 0 ]; then
        useradd ${app_user}
    fi
     func_print_heading "creating application folder"
        rm -rf /app
        mkdir /app
         func_print_heading "Downloading application content"
        curl -L -o /tmp/${component_name}.zip https://roboshop-artifacts.s3.amazonaws.com/${component_name}.zip
        cd /app
         func_print_heading "unzipping application content"
        unzip /tmp/${component_name}.zip
  }
  func_stat_check()
  {
    if [ $1 -eq 0 ]
    then
      echo -e "\e[32m Success \e[0m"
    else
      echo -e "\e[31m Failure \e[0m"
      exit 1
     fi

}
  
  func_java()
  {
     func_print_heading "Installing maven"
    dnf install maven -y
  func_stat_check $?

     func_print_heading "copying service file"


    func_print_heading "Mvn operations"
    mvn clean package
    mv target/${component_name}-1.0.jar shipping.jar
    
     func_print_heading "Installing mysql"
    dnf install mysql -y
    func_print_heading "loading schema"
    mysql -h mysql-dev.kruthikadevops.online -uroot -p${mysql_root_password} < /app/schema/${component_name}.sql
     func_print_heading "Staring shipping service"
    func_systemd
  }

  func_python()
  {
func_print_heading "Installing Python"
dnf install python36 gcc python3-devel -y
func_stat_check $?


func_prereq
func_print_heading "Install python dependencies"
pip3.6 install -r requirements.txt

func_systemd
sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}|" ${script_path}/payment.service
  }