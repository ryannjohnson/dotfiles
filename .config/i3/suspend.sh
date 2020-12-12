#!/bin/sh

revert() {
  xset s off
  xset -dpms
  xset s noblank
}

trap revert HUP INT TERM

i3lock -n -c '#000000' &

systemctl suspend

wait

revert
