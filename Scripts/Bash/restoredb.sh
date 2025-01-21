#!/bin/sh

set -e

DEFAULT_USER=benjamin
DEFAULT_HOST=localhost
DEFAULT_PORT=5432
DEFAULT_DB=strapi-plnts
DEFAULT_JOBS=4
DEFAULT_RECREATE_DB=1
FILE=$1

if test -f "$FILE"; then
    if [ "$DEFAULT_RECREATE_DB" = 1 ] ; then
        dropdb ${DEFAULT_DB} -p ${DEFAULT_PORT} -U ${DEFAULT_USER}
        createdb ${DEFAULT_DB} -p ${DEFAULT_PORT} -U ${DEFAULT_USER}
        echo "$DEFAULT_DB removed and recreated!"
    fi
    pg_restore -d postgresql://${DEFAULT_USER}@${DEFAULT_HOST}:${DEFAULT_PORT}/${DEFAULT_DB} --jobs ${DEFAULT_JOBS} ${FILE}
    echo "$FILE has been restored to $DEFAULT_DB."
else
    echo "$FILE does not exist."
    exit 1
fi
