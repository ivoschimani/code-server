FROM linuxserver/code-server:latest

LABEL org.opencontainers.image.authors="ivo@schimani.de"

RUN apt update && apt install -y software-properties-common && add-apt-repository ppa:ondrej/php

RUN apt update && apt install -y php php-cli php-mysql php-sqlite3 php-intl php-mbstring php-curl php-xml php-gd php-imagick php-zip unzip

RUN set -ex \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
  && php -r "unlink('composer-setup.php');" \
  && chmod +x /usr/local/bin/composer
  
RUN chsh -s /bin/bash abc

EXPOSE 8443