# ---
# image for building
# ---
FROM nginx:1.21 as builder

RUN apt update -y && apt upgrade -y
RUN apt install -y git vim
RUN apt install -y pkg-config build-essential autoconf libxml2-dev libssl-dev libsqlite3-dev zlib1g-dev libbz2-dev libcurl4-openssl-dev libpng-dev libjpeg-dev libonig-dev libreadline-dev libtidy-dev libxslt1-dev libzip-dev

WORKDIR /root
RUN git clone https://github.com/php-build/php-build.git
WORKDIR /root/php-build
RUN PREFIX=/root/.php-build ./install.sh

WORKDIR /root/php-build/bin
RUN PHP_BUILD_EXTRA_MAKE_ARGUMENTS="-j$(cat /proc/cpuinfo | grep processor | wc -l)" ./php-build 8.1.1 /root/.php/8.1.1

# ---
# production image
# ---
FROM nginx:1.21

RUN apt update -y && apt upgrade -y
RUN apt install -y bzip2 curl libjpeg62-turbo libonig5 libpng16-16 libreadline8 libssl1.1 libxslt1.1 libxml2 libzip4 sqlite3 tidy zlib1g zip

RUN mkdir -p /root/.php/8.1.1
COPY --from=builder /root/.php/8.1.1 /root/.php/8.1.1
RUN echo "PATH=$HOME/.php/8.1.1/bin:$PATH" >> ~/.bashrc

# configure php-fpm
RUN sed -i 's/;listen\.allowed_clients = 127\.0\.0\.1/listen.allowed_clients = 127.0.0.1/' /root/.php/8.1.1/etc/php-fpm.d/www.conf
RUN sed -i 's/user = nobody/user = nginx/' /root/.php/8.1.1/etc/php-fpm.d/www.conf
RUN sed -i 's/group = nobody/group = nginx/' /root/.php/8.1.1/etc/php-fpm.d/www.conf

RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bk
RUN mkdir -m 755 /data/

COPY file/run.sh /root/
RUN chmod 544 /root/run.sh

CMD ["/root/run.sh"]
