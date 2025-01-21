#!/usr/bin/env bash

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
