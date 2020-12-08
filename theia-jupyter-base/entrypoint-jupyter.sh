#!/bin/bash
# entrypoint-jupyter.sh - set the umask and start jupyter lab

umask 0002
exec jupyter lab
