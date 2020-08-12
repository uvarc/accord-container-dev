#!/bin/bash

podman build -f Containerfile -t lnxjedi/gopherbot-aws-k8s:latest -t 474683445819.dkr.ecr.us-east-1.amazonaws.com/accord/gopherbot-aws-k8s:latest .
