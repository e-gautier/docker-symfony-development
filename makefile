SHELL:=/bin/bash
DC=docker-compose
CONSOLE=bin/console

.PHONY: help

help:
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"


all:
ifeq (${project},)
	echo "Argument project name is not defined, define with make <target> project=<project_root_name>" && exit 1
endif

up: ## docker-compose up
	${DC} up -d

down: ## docker-compose down
	${DC} down

restart: down up  ## down & up

install: all up ## make up and composer install.
	${DC} exec -u www-data php-fpm bash -c "cd ${project} && composer install"

require: all up ## Composer require.
ifeq (${package},)
	echo "Package is not defined, define with make <target> project=<project_root_name> package=<package>" && exit 1
endif
	${DC} exec -u www-data php-fpm bash -c "cd ${project} && composer require ${package}"

new: all up ## make up, create a new Symfony project, install and edit hosts.
	${DC} exec -u www-data php-fpm bash -c "symfony new ${project} && cd ${project} && composer install"
	pkexec bash -c "echo '127.0.0.1 ${project}.dev' >> /etc/hosts" && \
	firefox -new-tab ${project}.dev || google-chrome ${project}.dev

db-create: all up ## Create database
	${DC} exec -u www-data php-fpm bash -c "cd ${project} && php ${CONSOLE} doctrine:database:create"

db-update: all up ## Update database (force)
	${DC} exec -u www-data php-fpm bash -c "cd ${project} && php ${CONSOLE} doctrine:schema:update --force"

clean: all ## Remove the hosts entry.	
	pkexec sed -i '/${project}.dev/d' /etc/hosts

