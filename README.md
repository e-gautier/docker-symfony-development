# docker-symfony-development

Setup a Docker environment and a 1..n Symfony ^3 project(s).
```
curl -L https://git.io/vbLSV | bash
```
## Requirements
- [Docker](https://docs.docker.com/engine/installation/)
- [Docker compose](https://docs.docker.com/compose/install/)

## Commands
```
make
```
```
up         docker-compose up
down       docker-compose down
restart    down & up
```
with a project name argument (eg. make install project=myproject)
> **Note:**
> Assuming that the <project> argument is the root name of the project.
> eg. /home/john/Desktop/myproject
```
install    make up and composer install.
require    Composer require.
new        make up, create a new Symfony project, install and edit hosts.
db-create  Create database
db-update  Update database (force)
clean      Remove the hosts entry.
```

## ELK
If elk is failing it probably needs more vm allocation (see [this link](https://www.elastic.co/guide/en/elasticsearch/reference/5.0/vm-max-map-count.html#vm-max-map-count))
```
sudo sysctl -w vm.max_map_count=262144 && sudo bash -c 'echo "vm.max_map_count=262144" >> /etc/sysctl.conf'
```

