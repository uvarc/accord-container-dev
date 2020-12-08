#!/bin/bash
# entrypoint-rstudio.sh - set the umask and start rstudio server

umask 0002
exec /usr/lib/rstudio-server/bin/rserver --auth-minimum-user-id=490
