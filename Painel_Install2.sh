#!/bin/bash
rm /etc/localtime && ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
apt-get update
#apt-get upgrade -y
apt-get install curl -y
apt-get install apache2 -y
apt-get install php5 libapache2-mod-php5 php5-mcrypt -y
apt-get install mysql-server -y
#  mysql_install_db
mysql_secure_installation
apt-get install phpmyadmin -y
php5enmod mcrypt
service apache2 restart
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
apt-get install libssh2-1-dev libssh2-php -y
php -m |grep ssh2
cd 
apt-get install unzip
rm -rf painelssh2.zip
wget https://github.com/Eliotbr/Painel_install/raw/master/painelssh2.zip
mv painelssh2.zip /var/www/html/
cd /var/www/html
unzip painelssh2.zip
rm painelssh2.zip index.html
IP=$(wget -qO- ipv4.icanhazip.com)
read -p "Senha para mysql e Banco de dados: " SENHA
mysql -h localhost -u root -p$SENHA -e "CREATE DATABASE ssh"
service apache2 restart
chmod -R 777 /var/www/html/admin/pages/bandeiras
chmod -R 777 /var/www/html/admin/pages/faturas/comprovantes
chmod -R 777 /var/www/html/admin/pages/download
chmod -R 777 /var/www/html/admin/pages/servidor/ovpn
chmod -R 777 /var/www/html/pages/faturasclientes/comprovantes
chmod -R 777 /var/www/html/pages/faturasclientes/minhas/comprovantes
rm -rf Painel_Install2.sh
clear
echo "
 1 - abra o arquivo pass.php e digite sua senha. Ex: <?php $pass = 'SUA_SENHA';?> 
nano /var/www/html/pages/system/pass.php"
echo "
2 - Acesse: $IP/phpmyadmin E crie um Banco de Dados SSH
 
3 - Dentro da VPS digite: 
crontab -e
escolha a opcao NANO e cole no arquivo os comanda abaixo:
 
* * * * * /usr/bin/php /var/www/html/pages/system/cron.php
* * * * * /usr/bin/php /var/www/html/pages/system/cron.ssh.php
* * * * * /usr/bin/php /var/www/html/pages/system/cron.sms.php
* * * * * /usr/bin/php /var/www/html/pages/system/cron.online.ssh.php
10 * * * * /usr/bin/php /var/www/html/pages/system/cron.servidor.php
service apache2 restart
  
    ******Final*******"
 
