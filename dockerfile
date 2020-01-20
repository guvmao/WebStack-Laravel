FROM alpine:3.9
LABEL "Mail":"guvmao@163.com"\
      "version":"v1.2.6"
ENV RUN_USER daemon 
ENV RUN_GROUP daemon
ENV INSTALL_DIR /opt/navi
ENV DB_HOST 127.0.0.1
ENV DB_PORT 3306
ENV DB_DATABASE homestead
ENV DB_USERNAME homestead
ENV DB_PASSWORD secret
ENV LOGIN_COPTCHA true 

ARG WEBSTACK_VERSION=v1.2.6
ARG DOWNLOAD_URL=https://github.com/CrazyBoyM/WebStack-Laravel/archive/${WEBSTACK_VERSION}.tar.gz
EXPOSE 8000

COPY entrypoint.sh /entrypoint.sh
RUN apk update -qq \
	&& apk upgrade \
	&& apk add --no-cache tini \
	   curl composer \
       php-pdo php-fileinfo  php-tokenizer php-gd php-dom  php-xmlwriter php-xml php-pdo_mysql php-session \
    && rm -rf /var/cache/apk/* \
    && mkdir -p ${INSTALL_DIR}

RUN curl -L --silent  ${DOWNLOAD_URL} | tar -xz --strip-components=1 -C "${INSTALL_DIR}" \
    && cd ${INSTALL_DIR} \
    && composer install  \
    && cp .env.example .env \
    && chown -R ${RUN_USER}:${RUN_GROUP} ${INSTALL_DIR}\
    && chown -R ${RUN_USER}:${RUN_GROUP} /entrypoint.sh

WORKDIR ${INSTALL_DIR}
CMD ["/entrypoint.sh", "serve"]
ENTRYPOINT ["/sbin/tini", "--"]
