# Docker-Live-Streaming
This repository will allow you to run an nginx server and host your video on that server
This container is based off of the information in this [blog post](https://thenotexpert.com/video-web-streaming-server-docker-linux/)

#Usage
##Prequisites
* To be able to use this container you will need a [docker](https://www.docker.com/products/docker-desktop) installation.
* To be able to stream you will need [OBS](https://obsproject.com/). 
* **Optional** it would be best to use a reverse proxy for hosting this container's frontend and content pages please see [linuxserver/swag](https://hub.docker.com/r/linuxserver/swag)
* If you are not using the reverse proxy approach then your `CONTENT_URL` below is going to be the same as your server ip for local hosting or your public ip for port forwarding hosting.

##Local build

To build this container after cloning this repo just run the following commands inside the cloned folder. 
~~~
docker build -t streaming:latest .
docker run -d --restart=always -p 21935:1935 -p 21936:1936 -p 21937:80\
-e CONTENT_URL=<the url of where the content will be hosted>\
-e STREAM_KEY=<stream key for obs>\
-e SERVER_IP=<ip address of the host running this container>\
--name stream streaming:latest
~~~

To know what your `CONTENT_URL` should be:
| Hosting | Content URL | Example |
| --- | --- | --- |
| Local | `http://<serverip>` | `http://192.168.0.33` |
| Port forwading | `http://<public ip>` | `https://8.8.8.8` |
| Reverse Proxy | `https://content.proxy.site` | `https://mycontent.my.duckdns.org` |

##OBS 
To stream the content you will need to set up obs to capture what you are willing to stream. In the stream settings for obs you will set a custom URL and it will use the format of `rtmp://<server ip>:21935/live` to send the content to the local docker container. The stream key must match the same key given to docker so that the frontend video player can access the content server.
