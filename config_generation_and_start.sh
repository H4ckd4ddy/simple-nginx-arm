#!/bin/bash

cp -f /etc/nginx/default.nginx.conf /etc/nginx/nginx.conf

config=""

while IFS='=' read -r name value
do
  if [[ $name == 'HOST_'* ]]
  then
    host="${!name}"
    input_host=$(echo $host | awk -F ">" '{print $1}')
    output_host=$(echo $host | awk -F ">" '{print $2}')
    input_port=$(echo $input_host | awk -F ":" '{print $2}')
    output_port=$(echo $output_host | awk -F ":" '{print $2}')
    input_host=$(echo $input_host | awk -F ":" '{print $1}')
    output_host=$(echo $output_host | awk -F ":" '{print $1}')
    new_host="server {
      listen *:$input_port;
      server_name $input_host;
      location / {
        proxy_pass http://$output_host:$output_port;
      }
    }"
    config="$config
    
    $new_host"
  fi
done < <(env)

tag='{{config}}'

replacement=$(sed -e 's/[&\\/]/\\&/g; s/$/\\/' -e '$s/\\$//' <<<"$config")

sed -i -e "s|$tag|$replacement|g" /etc/nginx/nginx.conf

nginx -g "daemon off;"
