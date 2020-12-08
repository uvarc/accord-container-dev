#!/bin/bash
# entrypoint-theia.sh - set the umask and start theia

umask 0002
exec node /usr/local/theia/src-gen/backend/main.js /home --hostname=0.0.0.0
