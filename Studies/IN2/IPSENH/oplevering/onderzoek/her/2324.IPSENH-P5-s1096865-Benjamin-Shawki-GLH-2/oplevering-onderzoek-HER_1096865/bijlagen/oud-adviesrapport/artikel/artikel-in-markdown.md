# Implementing Instant Rollback with Docker, Traefik, and GitLab CI/CD
## Overview
This section presents a comprehensive guide on setting up an instant rollback feature using [Docker](https://docs.docker.com/) for containerization, [Traefik](https://doc.traefik.io/traefik/) as a reverse proxy and load balancer, and [GitLab CI/CD](https://docs.gitlab.com/ee/topics/build_your_application.html) for continuous integration and deployment.
The goal is to ensure minimal downtime and maintain data integrity when rolling back to a previous, stable version of software in the event of a failure.

## Docker Configuration 
The docker-compose.prod.yml file defines the Docker services, including the Traefik reverse proxy and the placeholder for the frontend application. Traefik is configured to automatically generate and renew SSL certificates using Let's Encrypt, ensuring secure connections. The setup outlines how each service is containerized, emphasizing the Traefik configuration for secure routing and SSL termination.

Additionally, the configuration introduces automatic HTTP to HTTPS redirections, ensuring all traffic to your applications is securely encrypted. Furthermore, the configuration incorporates www trimming, redirecting requests from `www.example.com` to `example.com`, streamlining user access and simplifying domain management.

### docker-compose.prod.yml
~~~~~yml
version: '3.9'

services:
  traefik:
    image: traefik:v3.0
    ports:
      - 80:80
      - 443:443
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./letsencrypt:/letsencrypt
    command:
      - --api.insecure=true
      - --api.dashboard=true
      - --providers.docker=true
      - --providers.docker.exposedByDefault=false
      - --entrypoints.web.address=:80
      - --entrypoints.web.http.redirections.entrypoint.to=websecure
      - --entryPoints.web.http.redirections.entrypoint.scheme=https
      - --entrypoints.websecure.address=:443
      - --entrypoints.websecure.asDefault=true
      - --certificatesresolvers.letsencrypt.acme.tlschallenge=true
      # Todo: Replace with your email
      - --certificatesresolvers.letsencrypt.acme.email=mail@example.com
      - --certificatesresolvers.letsencrypt.acme.storage=/letsencrypt/acme.json

    labels:
      - traefik.enable=true
      - traefik.http.routers.traefik.rule=Host(`traefik.${ROOT_DOMAIN}`)
      - traefik.http.routers.traefik.service=api@internal
      - traefik.http.routers.traefik.entrypoints=websecure
      - traefik.http.routers.traefik.tls.certresolver=letsencrypt
      - traefik.http.middlewares.redirect-to-https.redirectscheme.scheme=https
      - traefik.http.routers.http-catchall.rule=HostRegexp(`{host:.+}`)
      - traefik.http.routers.http-catchall.entrypoints=web
      - traefik.http.routers.http-catchall.middlewares=redirect-to-https
    restart: unless-stopped

  # Todo: Add your database configuration as needed.
  # db:
  #   image: postgres:14
  #   volumes:
  #     - postgres_data:/var/lib/postgresql/data
  #   environment:
  #     POSTGRES_DB: ${POSTGRES_DB}
  #     POSTGRES_USER: ${POSTGRES_USER}
  #     POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
  #   ports:
  #     - "5433:5432"

  # Todo: Add your backend configuration as needed.
  # backend:
  #   image: ${IMAGE_BACKEND}
  # Todo: Add your Dockerfile path, context, and environment variables, volumes, and ports as needed.
  # depends_on:
  #   - db

  frontend-placeholder:
    image: ${CI_REGISTRY_IMAGE}/$CI_COMMIT_REF_NAME/frontend:${CI_COMMIT_SHORT_SHA}
    # Todo: Add your frontend configuration as needed.

    labels:
    - traefik.enable=true
    - traefik.http.routers.frontend-${CI_COMMIT_SHORT_SHA}.rule=${TRAEFIK_ROUTER_RULE}
    - traefik.http.routers.frontend-${CI_COMMIT_SHORT_SHA}.entrypoints=websecure
    - traefik.http.routers.frontend-${CI_COMMIT_SHORT_SHA}.tls.certresolver=letsencrypt
    - traefik.http.services.frontend-${CI_COMMIT_SHORT_SHA}.loadbalancer.server.port=80
    - traefik.http.middlewares.strip-www.redirectregex.regex=^https://www\.(.+)
    - traefik.http.middlewares.strip-www.redirectregex.replacement=https://$${1}
    - traefik.http.routers.frontend-${CI_COMMIT_SHORT_SHA}.middlewares=strip-www
    depends_on:
      - traefik

volumes:
  letsencrypt:
    name: letsencrypt
  # postgres_data:
~~~~~

_Key Components:_

- Traefik Service: 
: Acts as the entry point for all incoming requests, directing traffic to the appropriate container based on the request's host. It also handles SSL certificates automatically.
- Frontend Service Placeholder:
: A template for deploying the frontend application. It's tagged with a unique commit SHA to allow for instant rollbacks by switching traffic to a container tagged with the desired version.
- **Automatic HTTPS Redirection**:
: The configuration employs Traefik's middleware to redirect all HTTP traffic to HTTPS, safeguarding data in transit.
- **WWW Trimming**:
: Utilizing Traefik's redirectregex middleware, the setup automatically handles requests to `www.` subdomains by redirecting them to the non-www version of the URL, enhancing SEO and user experience.


## GitLab CI/CD Pipeline
The .gitlab-ci.yml file demonstrates the continuous integration and deployment process. It includes stages for building the Docker images and deploying them to the production environment. The deployment stage dynamically updates the docker-compose.prod.yml file to reflect the current commit SHA, facilitating versioning and rollback.

### .gitlab-ci.yml
~~~~~yml
# CI/CD Pipeline Configuration example for a containerized application with Docker, Traefik, and GitLab CI/CD.

stages:
  # - analyze
  - build
  - deploy

# Default settings for Docker, applied globally unless specifically overridden.
default:
  image: docker:24.0.5
  services:
    - docker:24.0.5-dind

# Global variables defining Docker configurations and image naming conventions.
variables:
  # Docker environment settings.
  DOCKER_DRIVER: overlay2
  DOCKER_TLS_CERTDIR: "/certs"

  # Naming for Docker images, facilitating version control and latest builds.
  IMAGE_FRONTEND: $CI_REGISTRY_IMAGE/$CI_COMMIT_REF_NAME/frontend:$CI_COMMIT_SHORT_SHA
  # IMAGE_BACKEND: $CI_REGISTRY_IMAGE/$CI_COMMIT_REF_NAME/backend:$CI_COMMIT_SHORT_SHA
  # IMAGE_E2E_TEST: $CI_REGISTRY_IMAGE/$CI_COMMIT_REF_NAME/e2e-test:$CI_COMMIT_SHA

  # Secure login to Docker registry.
  DOCKER_LOGIN: echo $CI_REGISTRY_PASSWORD | docker login -u $CI_REGISTRY_USER --password-stdin $CI_REGISTRY

  # Todo: Replace with your root domain.
  ROOT_DOMAIN: example.com

# Depending on the pipleline, you might want an analyze stage to validate the code quality and syntax for both frontend and backend, and unit tests here.

# Analyze stage:

# Build stage: Creates Docker images for frontend, backend, and E2E testing.

# Commands for building and pushing Docker images included.
build-frontend:
  stage: build
  before_script:
  - sh -c "$DOCKER_LOGIN"
  script:
    - docker compose -f docker-compose.prod.yml build frontend-placeholder
    - docker push $IMAGE_FRONTEND
  only:
    - main

# Example of building a backend with docker compose.
# build-backend:
#   stage: build
#   before_script:
#   - sh -c "$DOCKER_LOGIN"
#   script:
#     - docker compose -f docker-compose.prod.yml build backend
#     - docker push $IMAGE_BACKEND
#   only:
#     - main

deploy:
  stage: deploy
  image: alpine:3.14
  before_script:
    - apk add gettext openssh-client
  script:
    - export SERVICE_NAME="frontend-${CI_COMMIT_SHORT_SHA}"
    - export TRAEFIK_ROUTER_RULE="Host(\`${CI_COMMIT_SHORT_SHA}.${ROOT_DOMAIN}\`) || Host(\`${ROOT_DOMAIN}\`)"

    - sed -i "s|frontend-placeholder|${SERVICE_NAME}|g" docker-compose.prod.yml
    - sed -i "s|\${CI_COMMIT_SHORT_SHA}|${CI_COMMIT_SHORT_SHA}|g" docker-compose.prod.yml
    - sed -i "s|\${ROOT_DOMAIN}|${ROOT_DOMAIN}|g" docker-compose.prod.yml
    - sed -i "s|\${CI_REGISTRY_IMAGE}|${CI_REGISTRY_IMAGE}|g" docker-compose.prod.yml

    - envsubst < docker-compose.prod.yml > docker-compose.prod.subst.yml
    - eval $(ssh-agent)
    - echo "$ID_RSA" | tr -d '\r' | ssh-add -
    - mkdir -p ~/.ssh
    - chmod 700 ~/.ssh
    - touch ~/.ssh/known_hosts
    - chmod 600 ~/.ssh/known_hosts
    - ssh-keyscan -H $SERVER_IP >> ~/.ssh/known_hosts
    - scp docker-compose.prod.subst.yml $SERVER_USER@$SERVER_IP:/home/deployer/${CI_COMMIT_SHORT_SHA}-docker-compose.prod.yml
    - ssh $SERVER_USER@$SERVER_IP "
        cd /home/$SERVER_USER;

        docker compose -f ${CI_COMMIT_SHORT_SHA}-docker-compose.prod.yml up -d;

        ./make-sha-root-domain.sh '${CI_COMMIT_SHORT_SHA}' '$ROOT_DOMAIN';
      "

# Todo: add end to end tests after the deployment and trigger a rollback to the previous sha if the tests fail
~~~~~

_Pipeline Stages:_

- Build:
: Compiles the application and packages it into Docker images, tagging each with the commit SHA for version tracking.
- Deploy:
: Updates the deployment configuration with the new version and applies it to the production environment. It employs environment variables to adjust service names and routing rules dynamically, ensuring each deployment is accessible via a unique URL.

## Automated Rollback Script{- .unnumbered }
The scripts/make-sha-root-domain.sh script facilitates the instant rollback process. By specifying the commit SHA of the version to rollback to, this script adjusts the Traefik routing rules to direct traffic to the container associated with that SHA. This mechanism allows for immediate switchovers without downtime.

### scripts/make-sha-root-domain.sh
~~~~~sh 
#!/usr/bin/env bash

# Ensures the script is called with exactly two arguments.
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <short_sha_of_service> <root_domain>"
    exit 1
fi

TARGET_SHA=$1
ROOT_DOMAIN=$2
DEPLOYMENT_DIR="$HOME/"

# Updates the routing rule for a given service SHA.
update_routing_rule() {
    local sha=$1
    local file="${DEPLOYMENT_DIR}${sha}-docker-compose.prod.yml"
    local add_root_domain=$2

    # Check if the Docker Compose file exists.
    if [ ! -f "$file" ]; then
        echo "File not found: $file"
        return
    fi

    # Determine the new rule based on whether to add or remove the root domain.
    local new_rule="Host(\`${sha}.${ROOT_DOMAIN}\`)"
    if [ "$add_root_domain" == "true" ]; then
        new_rule+=" || Host(\`${ROOT_DOMAIN}\`) || Host(\`www.${ROOT_DOMAIN}\`)"
    fi

    # Update the routing rule using yq.
    yq e -i "(.services.\"frontend-$sha\".labels.[] | select(test(\"traefik.http.routers.frontend-$sha.rule=\"))) = \"traefik.http.routers.frontend-$sha.rule=$new_rule\"" "$file"
}

# Redeploys the Docker Compose service by its SHA.
redeploy_service() {
    local sha=$1
    local file="${DEPLOYMENT_DIR}${sha}-docker-compose.prod.yml"
    docker compose -f "$file" up -d "frontend-$sha"
}

# Update the target service to include the root domain.
update_routing_rule "$TARGET_SHA" "true"
redeploy_service "$TARGET_SHA"

# Iterate over all running frontend services except the target.
docker ps --filter "name=${USER}-frontend-" --format "{{.Names}}" | grep -Eo 'frontend-[0-9a-f]+' | grep -v "frontend-$TARGET_SHA" | while read -r service; do
    sha=$(echo "$service" | cut -d'-' -f2)
    # Skip if the Docker Compose file for the SHA does not exist.
    if [ ! -f "${DEPLOYMENT_DIR}${sha}-docker-compose.prod.yml" ]; then
        continue
    fi
    # Update routing to remove the root domain, if present.
    update_routing_rule "$sha" "false"
    # Redeploy the service to apply the change.
    redeploy_service "$sha"
done

echo "Completed root domain update and redeployment."
~~~~~


_Script Features:_

- Flexible Rollback Triggering:
: Enables quick reversion to any previously deployed version by modifying Traefik's routing rules.
- No Downtime:
: Traffic rerouting happens instantaneously, maintaining user access to the application without interruptions.

## Integration and Testing
The integration of Docker, Traefik, and GitLab CI/CD creates a robust environment for deploying and managing applications with the flexibility to rollback instantly. Testing this setup involves deploying multiple versions of an application, then triggering rollbacks to ensure the system reacts as expected.

_Testing Considerations:_

- Automated Testing:
: Implement automated tests within the CI/CD pipeline to validate each deployment before it goes live. This ensures only stable versions are deployed to production.
- Rollback Scenarios:
: Simulate various failure scenarios to test the rollback mechanism's effectiveness, including immediate rollbacks after deployment and reverting to versions several deployments past.

## Prerequisites
Before diving into the implementation of the instant rollback feature, it's crucial to ensure that the Virtual Private Server (VPS) is properly configured with the necessary tools and software. This section outlines the requirements and provides guidance on preparing the system for deployment.

It's also important to ensure your DNS settings are correctly configured to support the instant rollback feature and HTTPS redirections. Specifically, a wildcard DNS record (e.g., `*.example.com`) should be in place to allow for the dynamic handling of subdomains through Traefik, facilitating seamless transitions between different application versions.

In short you'll need to have a DNS record like `*.example.com` pointing to the VPS IP address, this will allow you to access the deployments using subdomains like `commit-sha.example.com`. 
This is an example of a simple setup:

| Type | Hostname | Value |
|---------------- | --------------- | --------------- |
| A | example.com | 12.345.67.890 |
| A | *.example.com | 12.345.67.890 |
| CNAME | www.example.com | example.com |

### Essential Tools and Software
- Docker:
: Docker must be installed both on the VPS and the local development machine. Docker facilitates the creation, deployment, and management of containerized applications, making it easier to manage dependencies and streamline the deployment process.

- Docker Compose:
: Docker Compose is required for managing multi-container Docker applications. By using a YAML file to configure the application’s services, you can create and start all the services with a single command. Ensure that Docker Compose is available on the VPS to deploy the services defined in the docker-compose.prod.yml file.

- yq:
: yq is a lightweight and portable command-line YAML processor. The scripts/make-sha-root-domain.sh script uses yq to update the Docker Compose configuration dynamically. Make sure to install yq on the VPS where deployments are executed.

- SSH Access:
: Secure Shell (SSH) access to the VPS is required for executing commands remotely and transferring files, such as the updated Docker Compose file during deployment. Ensure that SSH keys are set up for secure and passwordless access to the VPS.

- GitLab Runner:
: If GitLab CI/CD is used for automation, a GitLab Runner must be installed and configured either on the VPS or on a dedicated CI/CD server. The Runner executes the jobs defined in the .gitlab-ci.yml file.

### Preparing the Environment
1. Install Docker and Docker Compose:
: Follow the official Docker documentation to install Docker and Docker Compose on your VPS and local development machine.

1. Install yq:
: yq can be installed via package managers like apt for Debian/Ubuntu. Refer to the yq GitHub repository for detailed installation instructions.

1. Configure SSH Access:
: Set up SSH keys for the user account on the VPS that will be used for deployments. Add the public key to the ~/.ssh/authorized_keys file for passwordless access.

1. Set Up GitLab Runner:
: Install GitLab Runner according to the instructions provided in the GitLab documentation. Register the Runner with your GitLab project to execute the CI/CD pipeline jobs.

### Verifying the Setup
Before proceeding with the deployment, verify that all required tools are correctly installed and configured:

- Run the following to check the installations.
    - `docker version`
    - `docker compose version`
    - `yq --version`
- Test SSH access to the VPS without entering a password.
- Check the GitLab Runner status to ensure it is ready to execute pipeline jobs.

With these prerequisites in place, you're well-prepared to implement the instant rollback feature using Docker, Traefik, and GitLab CI/CD. This foundation ensures a smooth and efficient deployment process, minimizing downtime and enhancing the overall reliability of the system.

## What's Next?
The instant rollback feature is a powerful tool for maintaining application stability and ensuring a seamless user experience. By combining Docker, Traefik, and GitLab CI/CD, you've established a deployment pipeline that supports rapid rollbacks to previous versions, reducing the impact of failures and errors.

To further enhance the rollback process, consider implementing a monitoring system that triggers rollbacks automatically based on predefined conditions, setting up alerts for critical events, provide a user-friendly interface for managing deployments, and developing a custom CLI for executing rollback commands.

Implementing an instant rollback feature enhances operational reliability and user satisfaction by ensuring that applications can quickly revert to a stable state in the event of a failure. This setup not only minimizes downtime but also provides a scalable and secure deployment pipeline suitable for modern web applications.
