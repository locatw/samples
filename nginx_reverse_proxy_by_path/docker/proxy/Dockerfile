FROM nginx:1.21

RUN apt update -y && apt upgrade -y
RUN apt install -y vim
RUN apt install -y procps
RUN apt install -y iputils-ping net-tools

RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bk
