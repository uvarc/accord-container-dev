#!/bin/bash

if [ ! "$REGISTRY" ]
then
	echo "REGISTRY unset"
	exit 1
fi

buildah push $REGISTRY/accord/theia-python:latest
