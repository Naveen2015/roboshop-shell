echo -e "\e[32m Installing Nodejs\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y
echo -e "\e[32m Adding Application user\e[0m"
useradd roboshop
echo -e "\e[32m copying userservice file to systemd\e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service
echo -e "\e[32m Creating application directory\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[32m Downloading application code/content \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
echo -e "\e[32m Unzipping application content \e[0m"
unzip /tmp/user.zip
echo -e "\e[32m Installing npm\e[0m"
npm install
echo -e "\e[32m Starting user service\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user