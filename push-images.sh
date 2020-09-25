#!/bin/bash

. .env

if [ ! "$REGISTRY" ]
then
	echo "REGISTRY unset, run setenv.sh in parent dir."
	exit 1
fi

for REPO in $@
do
    podman tag accord/$REPO $REGISTRY/accord/$REPO
    podman push $REGISTRY/accord/$REPO:latest
done
