#!/bin/bash -e

# setenv.sh - set the .env symlink for the desired registry.

status(){
    LINK=$(readlink -f .env)
    FILE=$(basename $LINK)
    if [ "$FILE" == ".env" ]
    then
        echo "No environment set."
        exit 0
    fi
    . .env
    ENVS=""
    for ENV in ?*.env
    do
        ENVS="$ENVS ${ENV%.env}"
    done
    echo "Environments:$ENVS"
    echo "Current environment ${FILE%.env}, registry: $REGISTRY"
    exit 0
}

if [ ! "$1" ]
then
    status
fi

FILE="${1%.env}"

if [ -e "$FILE.env" ]
then
    ln -snf "$FILE.env" ".env"
    status
fi
