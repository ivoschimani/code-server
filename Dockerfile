FROM linuxserver/code-server:latest

LABEL org.opencontainers.image.authors="ivo@schimani.de"

RUN apt update && apt install -y software-properties-common && add-apt-repository ppa:ondrej/php

RUN apt update && apt install -y php8.1 php8.1-cli php8.1-mysql php8.1-sqlite3 php8.1-intl php8.1-mbstring php8.1-curl php8.1-xml php8.1-gd php8.1-imagick php8.1-zip unzip

RUN set -ex \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
  && php -r "unlink('composer-setup.php');" \
  && chmod +x /usr/local/bin/composer
  
RUN chsh -s /bin/bash abc

EXPOSE 8443