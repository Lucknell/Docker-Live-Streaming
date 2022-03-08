#!/bin/bash

sed -i "s/https:\/\/mydomain.com\/hls\/STREAM_KEY.m3u8/${CONTENT_URL}\/hls\/${STREAM_KEY}.m3u8/" /var/www/html/index.html

RTMP=$(grep "rtmp" /etc/nginx/nginx.conf)

if [ -z "$RTMP" ];then #first run fill in file
  echo "day 0 config running"
  cat >> /etc/nginx/nginx.conf << EOF

  rtmp {
          server {
                  listen 1935;
                  chunk_size 4096;
  
                  application live {
                  live on;
                  record off;
  
                  allow publish ${SERVER_IP};
                  #deny publish all;
  
                  # Turn on HLS
                  hls on;
                  hls_path /mnt/hls/;
                  hls_fragment 3;
                  hls_playlist_length 60;
                  # disable consuming the stream from nginx as rtmp
                  deny play all;
                  }
          }
  }
EOF
fi

#mandatory for survival
exec "$@"
