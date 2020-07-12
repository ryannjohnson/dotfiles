# https://raspberrypi.stackexchange.com/a/753
(sleep 15 && xset s off) &         # don't activate screensaver
(sleep 15 && xset -dpms) &         # disable DPMS (Energy Star) features.
(sleep 15 && xset s noblank) &     # don't blank the video device

sct 3500

exec /etc/alternatives/x-window-manager
