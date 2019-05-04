FROM tobi312/rpi-nginx

COPY proxy.conf /etc/nginx/
COPY default.nginx.conf /etc/nginx/

COPY config_generation_and_start.sh /
RUN chmod 755 /config_generation_and_start.sh

CMD ["/config_generation_and_start.sh"]
