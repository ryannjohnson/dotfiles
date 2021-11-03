#!/bin/bash

set -e

source .env

FILEPATH=$1
if [[ -z "$FILEPATH" ]]; then
	echo "Filepath required." >&2
	exit 1
fi

aws s3 cp $FILEPATH s3://$AWS_BUCKET/$FILEPATH "${@:2}"
