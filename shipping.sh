echo -e "\e[32m Installing maven \e[0m"
dnf install maven -y
echo -e "\e[32m Adding Application user \e[0m"
useradd roboshop
echo -e "\e[32m copying service file\e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[32m creating application folder \e[0m"
rm -rf /app
mkdir /app
echo -e "\e[32m Downloading application content \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
echo -e "\e[32m unzipping application content \e[0m"
unzip /tmp/shipping.zip
echo -e "\e[32m Mvn operations \e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[32m Installing mysql \e[0m"
dnf install mysql -y
mysql -h mysql-dev.kruthikadevops.online -uroot -pRoboShop@1 < /app/schema/shipping.sql
echo -e "\e[32m Staring shipping service \e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping
