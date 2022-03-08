FROM ubuntu:latest
MAINTAINER lucknell <lucknell3@gmail.com>
RUN apt update
RUN apt install -y nginx libnginx-mod-rtmp
RUN cd /mnt && mkdir hls && chown www-data:www-data hls
WORKDIR /mnt
COPY index.html /var/www/html/index.html
COPY content.conf /content.conf
RUN chmod 644 /var/www/html/index.html
COPY ./docker_entrypoint.sh /
RUN chmod +x /docker_entrypoint.sh
ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
