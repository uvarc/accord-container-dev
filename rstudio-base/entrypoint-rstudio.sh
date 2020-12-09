#!/bin/bash
# entrypoint-rstudio.sh - set the umask, start ssh-agent,
# and start rstudio server

eval `ssh-agent -s`
umask 0002
exec /usr/lib/rstudio-server/bin/rserver --auth-minimum-user-id=490
