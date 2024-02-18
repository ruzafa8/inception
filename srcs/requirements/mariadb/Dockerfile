FROM alpine:3.18

RUN apk update \
	&& apk upgrade \
	&& apk add vim mariadb mariadb-client openrc\
	&& mkdir scripts

RUN openrc && touch /run/openrc/softlevel

COPY tools/entrypoint.sh scripts/entrypoint.sh
COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN chmod +x scripts/entrypoint.sh

entrypoint ["sh"]
CMD ["scripts/entrypoint.sh"]