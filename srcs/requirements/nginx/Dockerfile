FROM alpine:3.18

RUN apk upgrade \
	&& apk update \
	&& apk add nginx vim openssl \
	&& mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=SP/ST=MLG/L=Malaga/O=42/CN=aruzafa-.42.fr/UID=aruzafa-"

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx", "-g", "daemon off;" ]
