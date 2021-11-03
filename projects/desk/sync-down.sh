#!/bin/bash

set -e

source .env

function synccommand {
	aws s3 sync s3://$AWS_BUCKET . $@
}

CHANGES=$(synccommand --dryrun)
if [[ -z "$CHANGES" ]]; then
	echo "No changes to sync."
	exit 0
fi

echo "$CHANGES"

read -rp "Continue with sync? (Y/n): " ANSWER
if [[ "$ANSWER" != "Y" ]]; then
	exit 1
fi

synccommand
