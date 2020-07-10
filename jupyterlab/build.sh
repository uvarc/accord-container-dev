#!/bin/bash

if [ ! "$REGISTRY" ]
then
	echo "REGISTRY unset"
	exit 1
fi

cd skel
mkdir -p .empty
mkdir -p .yarn/bin
tar czvf ../skel.tar.gz .
cd ..

podman build -f Dockerfile -t $REGISTRY/accord/jupyter:latest .
