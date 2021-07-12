# Laboratorio Docker 02
## En este laboratio se crearán tres contenedores apuntando a tres archivos html (dev, cal, prd), lo cual cada contenedor tendrá su porpio puerto (80, 8080, 8081)
---
### Para el laboratorio se necesitará tener instalado los siguientes programas:
* Git (tener cuenta en github)
* Docker con imagen de Nginx
1. Ingresar a GitHub y loguearse.
2. Crear las tres ramas, en mi caso dev, cal y prd.
3. Creamos el archivo Dockerfile y el archivo index.html en casa ambiente, lo cual contiene el siguiente contenido:
~~~
$cat index.html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <title>Mi web NGINX</title>
    </head>
    <body>
        <p>Mi web en [Ambiente]</p>
    </body>
    </html>

$cat Dockerfile
    FROM nginx:1.20.1
    COPY ./index.html /usr/share/nginx/html/index.html
    EXPOSE 80
~~~
>Donde el index es una página web estática (esto para comprobar que cada ambiente tenga su archivo html y su puerto) y el archivo Dockerfile descarga una imagen de *Nginx* con una versión estable copia el archivo index y expone el puerto 80.
4. Construimos las imagenes con el siguiente comando:
~~~
$docker build -t dev:v1.0 .
~~~
>Se hace la misma construcción en los tres ambientes.
5. Validamos las imagenes creadas
~~~
$ docker images | head -n4
REPOSITORY        TAG       IMAGE ID       CREATED              SIZE
prd               v1.0      17eb5bcb9aea   About a minute ago   133MB
cal               v1.0      9265f14ef3b1   3 minutes ago        133MB
dev               v1.0      69301e7a055e   11 minutes ago       133MB
~~~
6. Construimos los contenedores con el siguiente comando:
~~~
$ docker run -dp 8080:80 --name=desa dev:v1.0
01b0e32b92b9c96f17de656f84425037320832a828fcead31efb46ed7a5019ce
$ docker run -dp 8081:80 --name=cali cal:v1.0
87f1d56c51b0abd66cafe1fedc26cf342a92a04cc1d544c726de78524a048a57
$ docker run -dp 80:80 --name=pord prd:v1.0
5d591ca874f4529c0d64a89cbe1affa09736c2b65d3f191502a67fb8e2ea141c
~~~
7. Validamos los contenedores creados.
~~~
$ docker ps
CONTAINER ID   IMAGE      COMMAND                  CREATED              STATUS              PORTS                                   NAMES
5d591ca874f4   prd:v1.0   "/docker-entrypoint.…"   6 seconds ago        Up 4 seconds        0.0.0.0:80->80/tcp, :::80->80/tcp       pord
87f1d56c51b0   cal:v1.0   "/docker-entrypoint.…"   32 seconds ago       Up 30 seconds       0.0.0.0:8081->80/tcp, :::8081->80/tcp   cali
01b0e32b92b9   dev:v1.0   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8080->80/tcp, :::8080->80/tcp   desa
~~~
