#!/bin/sh

revert() {
  xset s off
  xset -dpms
  xset s noblank
}

trap revert HUP INT TERM

i3lock -n -c '#000000' &

xset -display :0.0 dpms force off

wait

revert
