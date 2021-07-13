# Laboratorio Docker 02 (Ambiente Desa)
## En este laboratio se crearán tres contenedores apuntando a tres archivos html (dev, cal, prd), lo cual cada contenedor tendrá su porpio puerto (80, 8080, 8081)

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
>Donde *-t* indica el tag (nombre).
5. Validamos las imagenes creadas
~~~
$ docker images
REPOSITORY        TAG       IMAGE ID       CREATED              SIZE
dev               v1.0      69301e7a055e   11 minutes ago       133MB
~~~
6. Construimos los contenedores con el siguiente comando:
~~~
$ docker run -dp 8080:80 --name=desa dev:v1.0
01b0e32b92b9c96f17de656f84425037320832a828fcead31efb46ed7a5019ce

~~~
7. Validamos los contenedores creados.
~~~
$ docker ps
CONTAINER ID   IMAGE      COMMAND                  CREATED              STATUS              PORTS                                   NAMES
5d591ca874f4   prd:v1.0   "/docker-entrypoint.…"   6 seconds ago        Up 4 seconds        0.0.0.0:80->80/tcp, :::80->80/tcp       pord
87f1d56c51b0   cal:v1.0   "/docker-entrypoint.…"   32 seconds ago       Up 30 seconds       0.0.0.0:8081->80/tcp, :::8081->80/tcp   cali
01b0e32b92b9   dev:v1.0   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8080->80/tcp, :::8080->80/tcp   desa
~~~
