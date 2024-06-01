dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y
useradd roboshop
mkdir /app
cp catalogue.service /etc/systemd/system/catalogue.service
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

npm install
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
dnf install mongodb-org-shell -y
mongo --host mongod-dev.kruthikadevops.online	</app/schema/catalogue.js
