# Práctica: Administración de Wordpress con la utilidad WP-CLI

En esta práctica vamos a realizar la administración de un sitio WordPress desde el terminal con la utilidad WP-CLI.

Con la utilidad WP-CLI podemos realizar las mismas tareas que se pueden hacer desde el panel de administración web de WordPress, pero desde la línea de comandos.

### Requisitos

La máquina donde vamos a instalar la utilidad WP-CLI será la misma máquina donde queremos realizar la instalación de WordPress y tendrá que tener instalado todo el software necesario de la pila LAMP.

## Instalación de WP-CLI en el servidor LAMP 

Descargamos el archivo `wp-cli.phar` del repositorio oficial de WP-CLI. Los archivos `.phar` son unos archivos similares a los archivos `.jar` de Java. Estos archivos se utilizan para distribuir aplicaciones o librerias de PHP en un único archivo

`curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar`

Le asignamos permisos de ejecución al archivo wp-cli.phar

`chmod +x wp-cli.phar`

Movemos el archivo `wp-cli.phar` al directorio `/usr/local/bin/` con el nombre de `wp` para poder utilizarlo sin necesidad de escribir la ruta completa donde se encuentra

`sudo mv wp-cli.phar /usr/local/bin/wp`

Una vez realizado el paso anterior si escribimos en la consola `wp` nos mostrará una página de ayuda del comando

## Ejemplo de uso: Instalación de wordpress con WP-CLI

El ejemplo de su uso es sobre una máquina que ya tiene instalado todo el software necesario de la Pila LAMP

### Paso 1. Descarga del código fuente de Wordpress (`wp core download`)

Nos situamos en el directorio donde queremos realizar la instalación de Wordpress
`cd /var/www/html`

Descargamos el código fuente de Wordpress con el comando:
`wp core download`

Si añadimos el parámetro `-path` podemos indicar el directorio , tambien podemos seleccionar el idioma con `--locale=es_ES`

`wp core download --path=/var/www/html -locale=es_ES`

### Paso 2. Creación del archivo de configuración (`wp config create`)

Antes de crear el archivo de configuración debemos crear en MySQL Server la base de datos, el usuario y la contraseña donde vamos a instalar WordPress.

Una vez que hemos creado la base de datos, usuario y contraseña en MySQL Server, podemos crear el archivo de configuración `wp-config.php` para Wordpress con el siguiente comando:
`wp config create --dbname=wordpress_db --dbuser=wordpress_user --dbpass=wordpress_password`

EN este paso le indicamos los siguientes parámetros:
 - `--dbname=wordpress_db` (Nombre de la BD)
 - `--dbuser=wordpress_user`(Usuario de la BD)
 - `--dbpass=wordpress_password`(Contraseña del usuario de BD)

Al crear el archivo de configuración se creearán automáticamente los valores aleatorios para las security Keys.

### Paso 4. Instalación de Wordpress (`wp core install`)

Una vez que tenemos la base de datos creada y el archivo de configuración preparado podemos realizar la instalación de WordPress con el comando:
`wp core install --url=localhost --title="IAW" --admin_user=admin --admin_password=admin_password --admin_email=test@test.com`

En este paso le estamos indicando los siguientes parámetros:

- `--url=localhost`(DOminio del sitio Wordpress. En nuestro caso será `localhost` o la dirección IP del servidor. En una instalación en producción utilizaremos el nombre del dominio del sitio)
- `--tittle="IAW"` (Titulo del sitio de Wordpress)
- `--admin_user=admin`(Nombre del usuario administrador)
- `--admin_password=admin_password`(Contraseña del usuario administrador)
- `--admin_email=test@test.com`(Email del usuario administrador)




## Parte del Script WP-CLI
Teniendo en cuenta que esta todo instalado de la pila LAMP
```
######################
#   Variables        #
######################

BD_NOMBRE=wpiaw
BD_USUARIO=resti
IP_FRONT=localhost
BD_PASS=root
URL=http://34.229.179.16
# Configuración de base de datos

mysql -u root <<< "DROP DATABASE IF EXISTS $BD_NOMBRE;"
mysql -u root <<<"CREATE DATABASE $BD_NOMBRE;"
mysql -u root <<<"DROP USER IF EXISTS $BD_USUARIO@$IP_FRONT;"
mysql -u root <<<"CREATE USER $BD_USUARIO@$IP_FRONT IDENTIFIED BY '$BD_PASS';"
mysql -u root <<<"GRANT ALL PRIVILEGES ON $BD_NOMBRE.* TO $BD_USUARIO@$IP_FRONT;"
mysql -u root <<<"FLUSH PRIVILEGES;"

# Nos descargamos el cliente de Wordpress
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Damos permisos de ejecución
chmod +x wp-cli.phar

# Lo movemos a la ruta indicada
mv wp-cli.phar /usr/local/bin/wp

# Cambiamos al directorio de instalación
cd /var/www/html
rm -rf index.html
# Descargamos el Wordpress en español
wp core download --locale=es_ES --allow-root

# Crear el archivo de configuración
wp config create --dbname=$BD_NOMBRE --dbuser=$BD_USUARIO --dbpass=$BD_PASS --allow-root

# Instalamos el cliente de Wordpress
wp core install --url=$URL --title="IAW_RESTI" --admin_user=resti --admin_password=root --admin_email=test@test.com --allow-root

```
