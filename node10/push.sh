#!/bin/bash

. ../.env
WD=$(pwd)
REPO=$(basename $WD)

if [ ! "$REGISTRY" ]
then
	echo "REGISTRY unset, run setenv.sh in parent dir."
	exit 1
fi

buildah push $REGISTRY/accord/$REPO:latest
