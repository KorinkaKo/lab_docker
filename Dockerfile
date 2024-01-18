FROM alpine:3.14 
 
RUN apk --update add nginx && \ 
    rm -rf /var/www/* && \ 
    mkdir -p /var/www/my_project/img 
 
COPY index.html /var/www/my_project/ 
COPY img/img.jpg /var/www/my_project/img/ 
 
RUN chmod -R 755 /var/www/my_project && \ 
    addgroup -S korinka_group && \ 
    adduser -S korinka -G korinka_group -h /var/www/my_project 
 
RUN sed -i 's/\/var\/www\/html/\/var\/www\/my_project/g' /etc/nginx/nginx.conf && \ 
    sed -i 's/user nginx;/user korinka korinka_group;/g' /etc/nginx/nginx.conf 
 
EXPOSE 80 
CMD ["nginx", "-g", "daemon off;"]
