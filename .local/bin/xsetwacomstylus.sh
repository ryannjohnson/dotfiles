#!/bin/bash

TARGET_WIDTH="$1"
TARGET_HEIGHT="$2"

NUM_PATTERN='^[1-9][0-9]+?$'
if [[ ! "$TARGET_WIDTH" =~ $NUM_PATTERN ]]; then
	echo "width required" 1>&2
	exit 1
fi
if [[ ! "$TARGET_HEIGHT" =~ $NUM_PATTERN ]]; then
	echo "height required" 1>&2
	exit 1
fi

DEVICE_ID=$(
	xsetwacom --list devices \
		| grep 'type: STYLUS' \
		| awk -F"\t" '{print $2}' \
	        | awk -F": " '{print $2}'
)
if [[ ! "$DEVICE_ID" =~ $NUM_PATTERN ]]; then
	echo "device does not exist" 1>&2
	exit 1
fi

xsetwacom --set "$DEVICE_ID" ResetArea
AREA=$(xsetwacom --get "$DEVICE_ID" Area)
TABLET_WIDTH=$(echo $AREA | awk '{print $3}')
TABLET_HEIGHT=$(echo $AREA | awk '{print $4}')

TABLET_ASPECT=$(echo "$TABLET_WIDTH/$TABLET_HEIGHT" | bc -l)
TARGET_ASPECT=$(echo "$TARGET_WIDTH/$TARGET_HEIGHT" | bc -l)
TABLET_IS_WIDER=$(echo "$TABLET_ASPECT>$TARGET_ASPECT" | bc -l)
if [[ "$TABLET_IS_WIDER" == "1" ]]; then
	NEW_WIDTH=$(printf '%0.f' $(echo "$TABLET_HEIGHT*$TARGET_ASPECT" | bc -l))
	xsetwacom --set "$DEVICE_ID" Area 0 0 $NEW_WIDTH $TABLET_HEIGHT
else
	NEW_HEIGHT=$(printf '%0.f' $(echo "$TABLET_WIDTH/$TARGET_ASPECT" | bc -l))
	xsetwacom --set "$DEVICE_ID" Area 0 0 $TABLET_WIDTH $NEW_HEIGHT
fi
