# Laboratorio Docker 02 (Ambiente Cali)
### En este laboratorio se creará un contenedor en el ambiente de calidad, lo cual se le asignará el puerto 8081.
1. Clonamos el repositorio con el siguiente comando:
~~~
$git clone https://github.com/mariocampos/Laboratorio-docker-02.git -b cal
~~~
2. Ingresamos a la carpeta clonada:
~~~
$cd Laboratorio-docker-02/
~~~
3. Revisamos los archivos.
~~~
$ ls -l
  total 3
  -rw-r--r-- 1 mcampobe 1049089  82 Jul 10 13:55 Dockerfile
  -rw-r--r-- 1 mcampobe 1049089  25 Jul 10 13:54 README.md
  -rw-r--r-- 1 mcampobe 1049089 141 Jul 10 13:54 index.html
~~~
4. El contenido del archivo Dockerfile e index.html es el siguiente:
~~~
$cat index.html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <title>Mi web NGINX</title>
    </head>
    <body>
        <p>Mi web en CALIDAD</p>
    </body>
    </html>

$cat Dockerfile
    FROM nginx:1.20.1
    COPY ./index.html /usr/share/nginx/html/index.html
    EXPOSE 80
~~~
>Donde el index es una página web estática (esto para comprobar que cada ambiente tenga su archivo html y su puerto) y el archivo Dockerfile descarga una imagen de Nginx con una versión estable copia el archivo index y expone el puerto 80.
5. Construimos la imagen con el siguiente comando.
~~~
$docker build -t cal:v1.0 .
~~~
>Donde -t indica el tag (nombre).
6. Validamos las imagenes creadas
~~~
$ docker images
REPOSITORY        TAG       IMAGE ID       CREATED              SIZE
dev               v1.0      9265f14ef3b1   15 minutes ago       133MB
~~~
7. Construimos los contenedores con el siguiente comando:
~~~
$ docker run -dp 8080:80 --name=cali cal:v1.0
c5dffc2f671fccf4439c3bba80a5d949c1985191a232a0be1ce788dabb74bd37
~~~
8. Validamos los contenedores creados.
~~~
$ docker ps
CONTAINER ID   IMAGE      COMMAND                  CREATED              STATUS              PORTS                                   NAMES
5d591ca874f4   prd:v1.0   "/docker-entrypoint.…"   6 seconds ago        Up 4 seconds        0.0.0.0:80->80/tcp, :::80->80/tcp       pord
87f1d56c51b0   cal:v1.0   "/docker-entrypoint.…"   32 seconds ago       Up 30 seconds       0.0.0.0:8081->80/tcp, :::8081->80/tcp   cali
01b0e32b92b9   dev:v1.0   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8080->80/tcp, :::8080->80/tcp   desa
~~~
