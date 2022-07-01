# Build TS project to Docker image on private Docker registry

## Informations

### Action

The goal of this project is to:
1. Build a Typescript Project to Javascript
2. Create a Docker image
3. Push the image to a private Docker registry

### Image tag

Github Action will be launch on:
- `Push` on master branch, Docker image tag wil be `latest` 
- `Tag push` on master branch, Docker image tag will match git pushed tag.

⚠️ Only tags containing version prefix `v` will launch the Github Action.

### Image name

Docker image name will match the current lowercased Github repository name.

### Example of image name + tag

```
0xwryth/actions-test:latest
0xwryth/actions-test:v1.0
0xwryth/actions-test:v1.1
```

## Project Structure

Typescript files are located inside `./src` folder.

⚠️ `./dist` will be used as destination folder during compilation step.
Do not use this folder for another use.

## Github Secrets

This project is using the following secrets:
- `DOCKER_REGISTRY`: Private Docker registry domain name / IP address and port
- `DOCKER_REGISTRY_USERNAME`: Docker registry username
- `DOCKER_REGISTRY_TOKEN`: Docker registry access token

⚠️ Docker access token != Docker account password

⚠️ **DO NOT TRY PRINTING OUT SECRETS VARIABLES** !

# Additional information

## Private Github Registry

You can find an example of docker-compose configuration file to set up a private Docker registry at `./server/registry.yml`.

Please note that the current registry configuration is set to use `htpassword` as registry auth mechanism and needs to be use with a proper SSL certificate.

```
docker-compose up -d -f ./server/registry.yml
```

[How to Create Your Own Private Docker Registry](https://www.howtogeek.com/devops/how-to-create-your-own-private-docker-registry/)

## Restarting Docker container on image update

You can find an example of docker-compose configuration file to set up Watchtower at `./server/watchtower.yml`.

Watchtower is used to restart docker container on image update.
Please note that the current configuration is restarting either running, stopped or restarting container.

```
docker-compose up -d -f ./server/watchtower.yml
```

[Automated Docker Deployments Using Watchtower](https://betterprogramming.pub/automated-docker-deployments-using-watchtower-1b7414a755e5)

Since our private registry is using authentication, we need to let Watchtower log to the private Docker registry.
Without logging in Watchtower to our registry, we wouldn't be able to pull newly updated images.

Authentication is made with `./config.json` file.

[Private registries - Watchtower](https://containrrr.dev/watchtower/private-registries/#example)