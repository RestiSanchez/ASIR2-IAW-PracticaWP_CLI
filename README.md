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
