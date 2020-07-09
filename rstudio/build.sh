#!/bin/bash

if [ ! "$REGISTRY" ]
then
	echo "REGISTRY unset"
	exit 1
fi

podman build -f Dockerfile -t $REGISTRY/accord/rstudio:latest .
