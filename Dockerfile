FROM ubuntu:20.04

RUN apt-get update && \    
    apt-get upgrade -y && \
    apt-get install -y nginx && \    
    apt-get clean && \
    rm -rf /var/www/* && \    
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /var/www/my_project/img

COPY index.html /var/www/my_project/
COPY img/img.jpg /var/www/my_project/img/

RUN chmod -R 755 /var/www/my_project

RUN groupadd -r korinka_group && \    
    useradd --no-log-init -r -g korinka_group korinka && \
    chown -R korinka:korinka_group /var/www/my_project
RUN sed -i 's/\/var\/www\/html/\/var\/www\/my_project/g' /etc/nginx/sites-enabled/default && \
    nginx_user_file=$(grep -rl 'user .*;' /etc/nginx/) && \
    sed -i 's/user .*;/user korinka korinka_group;/g' "$nginx_user_file"

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
