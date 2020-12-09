#!/bin/bash
# entrypoint-jupyter.sh - set the umask, start ssh-agent,
# and start jupyter lab

eval `ssh-agent -s`
umask 0002
exec jupyter lab
