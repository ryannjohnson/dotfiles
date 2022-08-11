source /etc/X11/Xsession

# https://raspberrypi.stackexchange.com/a/753
xset s off         # don't activate screensaver
xset -dpms         # disable DPMS (Energy Star) features.
xset s noblank     # don't blank the video device

bash $HOME/.local/bin/xsetwacomautofit.sh
#sct 3500

# Required for org.freedesktop.Notifications to work.
systemctl --user import-environment DISPLAY

dbus-run-session /etc/alternatives/x-window-manager
#exec /etc/alternatives/x-window-manager
