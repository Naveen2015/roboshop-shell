rabbitmq_appuser_password=$1
if [ -z "$rabbitmq_appuser_password" ]
then
  echo RabbitMQ Password Missing
  exit
  fi
echo -e "\e[32m Setup Erland Repos\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
echo -e "\e[32m Setup RabbitMQ Repos\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
echo -e "\e[32m Install Erland and RabbitMQ\e[0m"
dnf install rabbitmq-server -y
echo -e "\e[32m Start RabbitMQ\e[0m"
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server
echo -e "\e[32m Adding Application User in RabbitMQ\e[0m"
rabbitmqctl add_user roboshop ${rabbitmq_appuser_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"