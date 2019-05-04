# simple-nginx-arm

#### The easiest to use nginx image for arm arch like raspberry

Ideal as web entrypoint of docker-compose stack, you can simply defined all your hosts in environment variables with this format :

```
HOST_FIRST_HOST_NAME=first-host-external-domain.com:80>target-container-name:8080
```

exemple in docker-compose.yam :

```
version: '3.2'
services:
  visualizer:
    image: alexellis2/visualizer-arm:latest
    volumes:
      - type: bind
        source: /var/run/docker.sock
        target: /var/run/docker.sock

  web-test:
    image: httpd

  nginx:
    image: hackdaddy/simple-nginx-arm
    depends_on:
      - web-test
      - visualizer
    ports:
      - "80:80"
    environment:
      - HOST_WEB_TEST=test.local:80>web-test:80
      - HOST_VISUALIZER=visual.local:80>visualizer:8080
```
