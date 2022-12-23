FROM linuxserver/code-server:latest

LABEL org.opencontainers.image.authors="ivo@schimani.de"

RUN apt update && apt install -y software-properties-common && add-apt-repository ppa:ondrej/php

RUN apt update && apt install -y php7.4 php7.4-cli php7.4-mysql php7.4-sqlite3 php7.4-intl php7.4-mbstring php7.4-curl php7.4-xml php7.4-gd php7.4-imagick php7.4-zip unzip

RUN set -ex \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
  && php -r "unlink('composer-setup.php');" \
  && chmod +x /usr/local/bin/composer
  
RUN chsh -s /bin/bash abc

EXPOSE 8443