FROM ubuntu:latest
MAINTAINER lucknell <lucknell3@gmail.com>
RUN apt update
RUN apt install -y nginx libnginx-mod-rtmp
RUN cd /mnt && mkdir hls && mkdir stream && chown www-data:www-data hls && chown www-data:www-data stream
WORKDIR /mnt
COPY index.html /var/www/html/index.html
COPY content.conf /content.conf
RUN chmod 644 /var/www/html/index.html
RUN  touch /var/log/nginx/access.log && touch /var/log/nginx/error.log && ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log
COPY ./docker_entrypoint.sh /
RUN chmod +x /docker_entrypoint.sh
ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
