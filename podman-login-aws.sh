#!/bin/bash

aws ecr get-login-password --region us-east-1 | podman login --username AWS --password-stdin 474683445819.dkr.ecr.us-east-1.amazonaws.com
