#!/bin/bash
set -x

. ../.env
WD=$(pwd)
REPO=$(basename $WD)

if [ ! "$REGISTRY" ]
then
	echo "REGISTRY unset, run setenv.sh in parent dir."
	exit 1
fi

BUILDER=${1:-podman}

if [ "$BUILDER" == "buildah" ]
then
	$BUILDER bud -f Dockerfile -t $REGISTRY/accord/$REPO:latest --build-arg REGISTRY=$REGISTRY .
else
	$BUILDER build -f Dockerfile -t $REGISTRY/accord/$REPO:latest --build-arg REGISTRY=$REGISTRY .
fi
