#!/bin/bash

# There were too many bugs when trying to implement org-roam
# using .dir-locals.el, so we'll just set the "global" settings
# each time we open projects.
#
# Switching between projects isn't a frequent thing, so this
# should be acceptable for now.

set -e

ROAM_DIR="$1"
if [[ -z "$ROAM_DIR" ]]; then
	read -p "Roam directory [~/path/to/roam]: " $ROAM_DIR
fi
if [[ -z "$ROAM_DIR" ]]; then
	echo "Required: must provide path to roam directory." >&2
fi

cp config.el.tmpl config.el
sed -i "s|{{ROAM_DIR}}|$ROAM_DIR|g" config.el
