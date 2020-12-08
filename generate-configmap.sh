#!/bin/bash

# generate-configmap.sh - generate ACCORD configmaps for user pods.

BASE="$1"
INTERFACE="$2"
WORKLOAD="$3"
PORT="$4"

if [ -e "$WORKLOAD/passwd" ]
then
    PASSWD="$(cat $WORKLOAD/passwd | while read LINE; do echo '   ' $LINE; done)"
else
    PASSWD="$(cat $BASE/passwd | while read LINE; do echo '   ' $LINE; done)"
fi

if [ -e "$WORKLOAD/group" ]
then
    GROUP="$(cat $WORKLOAD/group | while read LINE; do echo '   ' $LINE; done)"
else
    GROUP="$(cat $BASE/group | while read LINE; do echo '   ' $LINE; done)"
fi

cat <<EOF
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
