# Pint and Pillage Containerized ITSTEN & IPSENH

> [!WARNING]
> Outdated

## Installation

Run the following command to clone the repository and its submodules:

```bash
git clone git@gitlab.com:benjaminshawki/pintandpillage-containerized.git
```

```bash
cd pintandpillage-containerized
```

```bash
cp .env.example .env
```

Proceed to fill in the `.env` file with the appropriate values. Followed by running the following command:

```bash
docker compose --env-file ./.env up --build
```

Run the tests

```bash
docker compose -f docker-compose.yml -f docker-compose.ci.yml up --build
```

## Deployment

Make sure to have the script deploy-and-cleanup.sh in the /home/deployer directory on the server. The script should be executable.
