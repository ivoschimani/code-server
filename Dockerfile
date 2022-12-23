FROM linuxserver/code-server:latest

LABEL org.opencontainers.image.authors="ivo@schimani.de"

RUN apt update && apt install -y software-properties-common && add-apt-repository ppa:ondrej/php

RUN apt update && apt install -y php7.3 php7.3-cli php7.3-mysql php7.3-sqlite3 php7.3-intl php7.3-mbstring php7.3-curl php7.3-xml php7.3-gd php7.3-imagick php7.3-zip unzip

RUN set -ex \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
  && php -r "unlink('composer-setup.php');" \
  && chmod +x /usr/local/bin/composer
  
RUN chsh -s /bin/bash abc

EXPOSE 8443