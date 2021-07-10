FROM nginx:1.20.1
COPY ./index.html /usr/share/nginx/html/index.html
RUN apt-get install -y postscript-viewer && apt install net-tools
