FROM lorisleiva/laravel-docker:stable

ENV INSTALL_DIR=/var/www
ENV DB_HOST=127.0.0.1
ENV DB_PORT=3306
ENV DB_DATABASE=homestead
ENV DB_USERNAME=homestead
ENV DB_PASSWORD=secret
ENV LOGIN_COPTCHA=true

ARG WEBSTACK_VERSION=v1.2.4
ARG DOWNLOAD_URL=https://github.com/hui-ho/WebStack-Laravel/archive/${WEBSTACK_VERSION}.tar.gz

COPY entrypoint.sh /entrypoint.sh

RUN mkdir -p ${INSTALL_DIR} && curl -L --silent  ${DOWNLOAD_URL} | tar -xz --strip-components=1 -C "${INSTALL_DIR}" && cd ${INSTALL_DIR} && \ 
    rm -rf composer.lock && \
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
    composer install  && \
    cp .env.example .env

EXPOSE 8000

CMD ["/entrypoint.sh", "serve"]
