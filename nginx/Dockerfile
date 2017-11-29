FROM debian:jessie

RUN apt-get update && apt-get install -y \
    nginx

# Add configuration.
ADD nginx.conf /etc/nginx/

# Mass VHosting configuration.
ADD default /etc/nginx/sites-available/

# phpinfo configuration
ADD phpinfo /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/phpinfo /etc/nginx/sites-enabled/

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80
EXPOSE 443

