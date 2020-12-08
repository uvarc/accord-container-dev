#!/bin/bash -e

# quaytrigger.sh - trigger a container build on quay.io
# NOTE: this is NOT general-purpose, but hard-coded to use
# with github.com/accord/XXX

if [ ! -e ".env" ]
then
    echo "Missing '.env' file."
    exit 1
fi

if [ ! "$1" ]
then
    echo "Missing argument: <container-name>"
    exit 1
fi

trap_handler()
{
    ERRLINE="$1"
    ERRVAL="$2"
    echo "line ${ERRLINE} exit status: ${ERRVAL}" >&2
    # The script should usually exit on error
    exit $ERRVAL
}
trap 'trap_handler ${LINENO} $?' ERR

source ".env"

REPO=$1
WEBHOOK_ENV=$(echo $REPO | tr - _)
WEBHOOK=${!WEBHOOK_ENV}

if [ ! "$WEBHOOK" ]
then
    echo "Webhook not found for $REPO"
    exit 1
fi

COMMIT=$(git rev-parse HEAD)

echo "Building master/commit: $COMMIT"

echo "{ \"commit\": \"$COMMIT\", \"ref\": \"refs/heads/master\", \"default_branch\": \"master\" }" | curl -X POST -H "Content-Type: application/json" -d @- $WEBHOOK

echo
exit 0
