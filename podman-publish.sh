#!/bin/bash

# podman-publish.sh - build the container, generate the configmap,
# and publish both. REGISTRY must be set.

if [ ! "$REGISTRY" ]
then
    echo "REGISTRY unset"
    exit 1
fi

if [ $# -ne 1 ]
then
    echo "Missing required argument <userpod>"
    exit 1
fi

USERPOD="$1"
WORKDIR="userpods/$USERPOD"

if [ ! -d $WORKDIR ]
then
    echo "No such directory: $WORKDIR"
    exit 1
fi

if [ ! -e $WORKDIR/vars ]
then
    echo "Missing vars file $WORKDIR/vars"
    exit 1
fi

source $WORKDIR/vars

INTERFACE=${USERPOD%%-*}
WORKLOAD=${USERPOD#*-}

get_template(){
    TEMPLATE=$1
    TFILE="$OSBASE/$TEMPLATE"
    if [ -e "$WORKDIR/$TEMPLATE" ]
    then
        TFILE="$WORKDIR/$TEMPLATE"
    elif [ -e "$UIBASE/$TEMPLATE" ]
    then
        TFILE="$UIBASE/$TEMPLATE"
    fi
    cat "$TFILE" | while read LINE; do echo "    $LINE"; done
}

PASSWD=$(get_template passwd)
GROUP=$(get_template group)

cat > $WORKDIR/$USERPOD-map.yaml <<EOF
apiVersion: "v1"
kind: "ConfigMap"
data:
  port: "$PORT"
  passwd: |
$PASSWD
  group: |
$GROUP
metadata:
  labels:
    workload: "$WORKLOAD"
    interface: "$INTERFACE"
    class: "userpod"
  name: "$INTERFACE-$WORKLOAD"
EOF
kubectl -n accord apply -f $WORKDIR/$USERPOD-map.yaml

podman build -f $WORKDIR/Dockerfile -t ${REGISTRY}/accord/${USERPOD}:latest $WORKDIR
podman push ${REGISTRY}/accord/${USERPOD}:latest
