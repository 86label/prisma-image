#!/bin/bash

#Replace default schema with mounted file
schema=$(ls /nexus/mounted)

if [ -f /nexus/mounted/$schema ]; then
    echo "Using $schema"
    cp /nexus/mounted/$schema /nexus/prisma/schema.prisma
else
    echo "Using default schema";
fi

# Generate
npx prisma generate
npx ts-node --transpile-only src/createTypes

# Migrate
npx prisma migrate save --name "$(date +%Y%m%d-%H%M%S)" --experimental
npx prisma migrate up --experimental

exec "$@"

