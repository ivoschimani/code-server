FROM linuxserver/code-server:latest

LABEL org.opencontainers.image.authors="ivo@schimani.de"

RUN apt update && apt install -y software-properties-common && add-apt-repository ppa:ondrej/php

RUN apt update && apt install -y php8.3 php8.3-cli php8.3-mysql php8.3-sqlite3 php8.3-intl php8.3-mbstring php8.3-curl php8.3-xml php8.3-gd php8.3-imagick php8.3-zip php8.3-mongodb unzip

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs

RUN set -ex \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
  && php -r "unlink('composer-setup.php');" \
  && chmod +x /usr/local/bin/composer
  
RUN chsh -s /bin/bash abc

EXPOSE 8443