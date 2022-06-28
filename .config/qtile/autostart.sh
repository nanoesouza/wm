#!/bin/sh

killall picom ; picom -f --experimental-backends --config $XDG_CONFIG_HOME/picom/picom.conf &
killall nitrogen ; nitrogen --restore &
killall dunst ; dunst &
setxkbmap br thinkpad &
libinput-gestures-setup autostart start &
rfkill unblock all &
xsetroot -cursor_name left_ptr &
~/.local/bin/dualmonitor

# Polybar
$XDG_CONFIG_HOME/polybar/launch.sh
