FROM linuxserver/code-server:latest

LABEL org.opencontainers.image.authors="ivo@schimani.de"

RUN apt-get install -y docker-ce-cli

RUN set -ex \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
  && php -r "unlink('composer-setup.php');" \
  && chmod +x /usr/local/bin/composer
  
RUN chsh -s /bin/bash abc

EXPOSE 8443