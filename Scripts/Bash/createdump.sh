#!/bin/bash

set -e

DEFAULT_USER=benjamin
DEFAULT_DB=strapi-plnts

currentDate=$(date +'%Y-%m-%d')
filename="${currentDate}_${RANDOM}_${DEFAULT_DB}-localhost.pgsql"

if test -f "${filename}"; then
    echo "File ${filename} already exists. Operation aborted."
    exit 1
else
    pg_dump -U ${DEFAULT_USER} -W -F c ${DEFAULT_DB} > "${filename}"
    echo "File ${filename} has been created."
fi
