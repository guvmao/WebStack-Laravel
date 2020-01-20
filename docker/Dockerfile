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

ARG GIT_URL=https://github.com/guvmao/WebStack-Laravel.git
EXPOSE 8000

COPY entrypoint.sh /entrypoint.sh
RUN apk update -qq \
	&& apk upgrade \
	&& apk add --no-cache tini \
	   git composer \
       php-pdo php-fileinfo  php-tokenizer php-gd php-dom  php-xmlwriter php-xml php-pdo_mysql php-session \
    && rm -rf /var/cache/apk/* \
    && mkdir -p ${INSTALL_DIR}

RUN git ${GIT_URL} ${INSTALL_DIR} \
    && cd ${INSTALL_DIR} \
    && composer install  \
    && cp .env.example .env \
    && chown -R ${RUN_USER}:${RUN_GROUP} ${INSTALL_DIR}\
    && chown -R ${RUN_USER}:${RUN_GROUP} /entrypoint.sh

WORKDIR ${INSTALL_DIR}
CMD ["/entrypoint.sh", "serve"]
ENTRYPOINT ["/sbin/tini", "--"]
