#!/bin/bash

# podman-run.sh - convenience script for local test run

if [ $# -ne 1 ]
then
    echo "Usage: podman-run.sh [theia|jupyter]"
    exit 0
fi

if [ "$1" = "theia" ]
then
    podman run -it -p 3000 --name theia theia-python
elif [ "$1" = "jupyter" ]
then
    podman run -it -p 8888 --name jupyter jupyter-python
else
    podman run -it -p 8787 --name rstudio rstudio-r
fi
