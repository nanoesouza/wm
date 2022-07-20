#!/bin/sh

killall picom ; picom -f --experimental-backends --config $XDG_CONFIG_HOME/picom/picom.conf &
killall nitrogen ; nitrogen --restore &
killall dunst ; dunst &
setxkbmap br thinkpad &
libinput-gestures-setup autostart start &
rfkill unblock all &
xsetroot -cursor_name left_ptr &
~/.local/bin/dualmonitor
xinput --set-prop 'pointer:USB Gaming Mouse' 'libinput Accel Profile Enabled' 0 0 &
xinput --set-prop 'pointer:USB Gaming Mouse' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1.50 &
# Polybar
#$XDG_CONFIG_HOME/polybar/launch.sh
