#!/usr/bin/env bash

set -e

MAP_TO_OUTPUT="$1"
if [[ -z "$MAP_TO_OUTPUT" ]]; then
	# At least with nvidia drivers, we're able to identify "outputs"
	# only in terms of the screen index.
	MAP_TO_OUTPUT="HEAD-0"
fi

SCREEN_DIMENSIONS=$(xrandr | grep '*' | awk '{print $1}' | head -1)
TARGET_WIDTH=$(echo $SCREEN_DIMENSIONS | awk -F'x' '{print $1}')
TARGET_HEIGHT=$(echo $SCREEN_DIMENSIONS | awk -F'x' '{print $2}')

DEVICE_ID=$(
        xsetwacom --list devices \
                | grep 'type: STYLUS' \
                | awk -F"\t" '{print $2}' \
                | awk -F": " '{print $2}'
)

xsetwacom --set "$DEVICE_ID" MapToOutput "$MAP_TO_OUTPUT"
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
