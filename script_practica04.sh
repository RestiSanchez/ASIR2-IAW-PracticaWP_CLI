#! /bin/bash

# Marcamos los pasos en la ejecución

set -x

# Actualizamos lista de paquetes

apt update 

# Actualizamos los paquetes

apt upgrade

# Instalamos el servidor web Apache

apt install apache2 -y

# Instalamos MySQL-Server

apt install mysql-server -y

# Instalamos los modulos de PHP

apt install php libapache2-mod-php php-mysql -y

######################
#   Variables        #
######################

BD_NOMBRE=wpiaw
BD_USUARIO=resti
IP_FRONT=localhost
BD_PASS=root
URL=http://xxxx
# Configuración de base de datos

mysql -u root <<< "DROP DATABASE IF EXISTS $DB_NAME;"
mysql -u root <<< "CREATE DATABASE $DB_NAME;"
mysql -u root <<< "DROP USER IF EXISTS $DB_USER@$IP_PRIVADA_FRONT;"
mysql -u root <<< "CREATE USER $DB_USER@$IP_PRIVADA_FRONT IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@$IP_PRIVADA_FRONT;"
mysql -u root <<< "FLUSH PRIVILEGES;"

# Nos descargamos el cliente de Wordpress
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Damos permisos de ejecución
chmod +x wp-cli.phar

# Lo movemos a la ruta indicada
mv wp-cli.phar /usr/local/bin/wp

# Cambiamos al directorio de instalación
cd /var/www/html
# Descargamos el Wordpress en español
wp core download --locale=es_ES

# Crear el archivo de configuración
wp config create --dbname=$BD_NOMBRE --dbuser=$BD_USUARIO --dbpass=$BD_PASS

# Instalamos el cliente de Wordpress
wp core install --url=$URL --title="IAW" --admin_user=resti --admin_password=root --admin_email=test@test.com

# 
