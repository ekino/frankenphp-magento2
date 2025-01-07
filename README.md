# Magento on FrankenPHP

## Requirements

- [Docker](https://docs.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/overview/)
- [Git](https://git-scm.com/)

## Installation

- copy and **configure** environment files:  
```
cp .env.dist .env
cp ./.docker/database/.env.dist ./.docker/database/.env
cp ./.docker/opensearch/.env.dist ./.docker/opensearch/.env
cp ./.docker/rabbitmq/.env.dist ./.docker/rabbitmq/.env
```
- edit the SERVER_NAME variable in the .env file and replace docker-magento-skeleton.localdev with your domain
- run the docker-compose file: `docker compose up -d --remove-orphans`
- use your composer files to install your project
- edit the file `/etc/hosts` of your machine and add your domain like this :

```
127.0.0.1 docker-magento-skeleton.localdev
```
