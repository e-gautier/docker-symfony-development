help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

## Setup a Docker environment and a 1..n Symfony project(s).
##
##	make install project=helloworld
##
## Arguments:
## 	- project: The project name, assuming it is the project root folder name.

install:
	docker-compose up -d && \
	docker-compose exec -u www-data php-fpm bash -c "cd ${project} && composer install"

new:
	docker-compose up -d && \
	docker-compose exec -u www-data php-fpm bash -c "symfony new ${project} && cd ${project} && composer install"

clean:
	rm -rf logs; \
	rm -rf db

