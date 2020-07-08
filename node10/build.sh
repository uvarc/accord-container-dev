#!/bin/bash

if [ ! "$REGISTRY" ]
then
	echo "REGISTRY unset"
	exit 1
fi

buildah bud -f Dockerfile -t $REGISTRY/accord/node10:latest .
