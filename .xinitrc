# https://raspberrypi.stackexchange.com/a/753
xset s off         # don't activate screensaver
xset -dpms         # disable DPMS (Energy Star) features.
xset s noblank     # don't blank the video device

sct 3200

exec /etc/alternatives/x-window-manager
