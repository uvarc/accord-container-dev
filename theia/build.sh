#!/bin/bash

. ../.env
WD=$(pwd)
REPO=$(basename $WD)

if [ ! "$REGISTRY" ]
then
	echo "REGISTRY unset, run setenv.sh in parent dir."
	exit 1
fi

podman build -f Dockerfile -t $REGISTRY/accord/$REPO:latest --build-arg REGISTRY=$REGISTRY .
