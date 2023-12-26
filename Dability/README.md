# Ejecución de d-ability

Bienvenido al proyecto d-ability del grupo accesible solutions. Este README te guiará a través del proceso de ejecución de la aplicación.

## Requisitos previos
Asegúrate de tener instalado lo siguiente en tu sistema Windows antes de comenzar:

- [XAMPP](https://www.apachefriends.org/index.html) instalado y configurado.
- Android Studio o Visual Studio Code para compilar la aplicación
- Archivos del proyecto descargados.

## Pasos de ejecución

1. Instala [XAMPP](https://www.apachefriends.org/index.html) en tu sistema.
2. Copia los archivos de la carpeta API al directorio de instalación de XAMPP, específicamente en `xampp/htdocs`.
3. Accede a [localhost/phpmyadmin](http://localhost/phpmyadmin) y crea una nueva base de datos llamada `d-ability`.
4. Importa el archivo `.sql` proporcionado en el directorio del proyecto a la base de datos `d-ability`.
5. Asegúrate de que tu dispositivo y tu PC estén conectados al mismo WiFi.
6. Abre PowerShell (Windows) o un terminal (Linux) y ejecuta el siguiente comando para obtener tu dirección IP dentro de la red WiFi:
   ```ipconfig``` en Windows e ```ifconfig``` en Linux. Busca la IP correspondiente al adaptador de red inalámbrico y copiala.
7. En el directorio del proyecto de Android, modifica el archivo .env y establece la dirección IP obtenida en el paso anterior.