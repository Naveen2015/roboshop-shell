echo -e "\e[32m Installing Nodejs\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y
echo -e "\e[32m Adding Application user\e[0m"
useradd roboshop
echo -e "\e[32m copying cart service file to systemd\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service
echo -e "\e[32m Creating application directory\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[32m Downloading application code/content \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
echo -e "\e[32m Unzipping application content \e[0m"
unzip /tmp/cart.zip
echo -e "\e[32m Installing npm\e[0m"
npm install
echo -e "\e[32m Starting cart service\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart