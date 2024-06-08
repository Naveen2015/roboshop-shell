echo -e "\e[36m configuring and installing Nodejs \e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y

echo -e "\e[36m Add Application User\e[0m"
useradd roboshop
echo -e "\e[36m Create Application Directory \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m Download App Content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "\e[36m unzip App Content\e[0m"


unzip /tmp/catalogue.zip

echo -e "\e[36m copy catalogue service file to systemd\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m NPM install\e[0m"

npm install
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
dnf install mongodb-org-shell -y
mongo --host mongod-dev.kruthikadevops.online	</app/schema/catalogue.js
