SHELL := /bin/bash
.PHONY: help

help:
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)""']]')"


all:
ifeq (${project},)
	echo "Argument project name is not defined, define with make <target> project=<project_root_name>" && exit 1
endif

up:
	docker-compose up -d

install: all up ## Setup Docker environment and install.
	docker-compose exec -u www-data php-fpm bash -c "cd ${project} && composer install"

new: all up ## Create a new Symfony project, setup Docker environement, install and edit hosts.
	docker-compose exec -u www-data php-fpm bash -c "symfony new ${project} && cd ${project} && composer install"
	pkexec bash -c "echo '127.0.0.1 ${project}.dev' >> /etc/hosts" && \
	firefox -new-tab ${project}.dev || google-chrome ${project}.dev

clean: all ## Remove the hosts entry.	
	pkexec sed -i '/${project}.dev/d' /etc/hosts

