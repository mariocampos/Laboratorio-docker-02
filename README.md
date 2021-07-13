# Laboratorio Docker 02 (Ambiente Prod)
### En este laboratorio se creará un contenedor en el ambiente de calidad, lo cual se le asignará el puerto 80.
1. Clonamos el repositorio con el siguiente comando:
~~~
$git clone https://github.com/mariocampos/Laboratorio-docker-02.git -b prd
~~~
2. Ingresamos a la carpeta clonada:
~~~
$cd Laboratorio-docker-02/
~~~
3. Revisamos los archivos.
~~~
$ ls -l
  total 3
  -rw-r--r-- 1 mcampobe 1049089  82 Jul 10 13:58 Dockerfile
  -rw-r--r-- 1 mcampobe 1049089  25 Jul 10 13:57 README.md
  -rw-r--r-- 1 mcampobe 1049089 141 Jul 10 13:56 index.html
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
        <p>Mi web en PRODUCCION</p>
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
$docker build -t prd:v1.0 .
~~~
>Donde -t indica el tag (nombre).
6. Validamos las imagenes creadas
~~~
$ docker images
REPOSITORY        TAG       IMAGE ID       CREATED              SIZE
prd               v1.0      17eb5bcb9aea   19 minutes ago       133MB
~~~
7. Construimos los contenedores con el siguiente comando:
~~~
$ docker run -dp 8080:80 --name=prod prd:v1.0
5d591ca874f4529c0d64a89cbe1affa09736c2b65d3f191502a67fb8e2ea141c
~~~
8. Validamos los contenedores creados.
~~~
$ docker ps
CONTAINER ID   IMAGE      COMMAND                  CREATED              STATUS              PORTS                                   NAMES
5d591ca874f4   prd:v1.0   "/docker-entrypoint.…"   6 seconds ago        Up 4 seconds        0.0.0.0:80->80/tcp, :::80->80/tcp       prod
87f1d56c51b0   cal:v1.0   "/docker-entrypoint.…"   32 seconds ago       Up 30 seconds       0.0.0.0:8081->80/tcp, :::8081->80/tcp   cali
01b0e32b92b9   dev:v1.0   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8080->80/tcp, :::8080->80/tcp   desa
~~~
