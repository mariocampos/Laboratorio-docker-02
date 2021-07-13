# Laboratorio Docker 02 (Ambiente Desa)
## En este laboratorio se creará un contenedor en el ambiente de calidad, lo cual se le asignará el puerto 8080.

1. Clonamos el repositorio.
~~~
$git clone https://github.com/mariocampos/Laboratorio-docker-02.git -b dev
~~~
2. Ingresamos a la carpeta extraída desde Github.
~~~
$cd Laboratorio-docker-02/
~~~
3. Revisamos los archivos.
~~~
$ ls -l
  total 3
  -rw-r--r-- 1 mcampobe 1049089  82 Jul 10 13:53 Dockerfile
  -rw-r--r-- 1 mcampobe 1049089  25 Jul 10 13:51 README.md
  -rw-r--r-- 1 mcampobe 1049089 141 Jul 10 13:51 index.html
~~~
4. Revisamos el archivo Dockerfile y el archivo index.html.
~~~
$cat index.html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <title>Mi web NGINX</title>
    </head>
    <body>
        <p>Mi web en DESARROLLO</p>
    </body>
    </html>

$cat Dockerfile
    FROM nginx:1.20.1
    COPY ./index.html /usr/share/nginx/html/index.html
    EXPOSE 80
~~~
>Donde el index es una página web estática (esto para comprobar que cada ambiente tenga su archivo html y su puerto) y el archivo Dockerfile descarga una imagen de *Nginx* con una versión estable copia el archivo index y expone el puerto 80.
5. Construimos la imagen con el siguiente comando:
~~~
$docker build -t dev:v1.0 .
~~~
>Donde *-t* indica el tag (nombre).
6. Validamos la imagen creada
~~~
$ docker images
REPOSITORY        TAG       IMAGE ID       CREATED              SIZE
dev               v1.0      69301e7a055e   11 minutes ago       133MB
~~~
7. Construimos los contenedores con el siguiente comando:
~~~
$ docker run -dp 8080:80 --name=desa dev:v1.0
01b0e32b92b9c96f17de656f84425037320832a828fcead31efb46ed7a5019ce

~~~
8. Validamos los contenedores creados.
~~~
$ docker ps
CONTAINER ID   IMAGE      COMMAND                  CREATED              STATUS              PORTS                                   NAMES
01b0e32b92b9   dev:v1.0   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8080->80/tcp, :::8080->80/tcp   desa
~~~
