#!/usr/bin/env bash
DIR="$HOME/.config/polybar"
HDMI=$(xrandr --query | grep 'HDMI1')

# Terminate already running bar instances
killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

echo "---" | tee -a /tmp/polybar.log
polybar -q main -c "$DIR"/config.ini 2>&1 | tee -a /tmp/polybar.log & disown

if [[ $HDMI = *connected* ]]; then
	polybar -q bar2 -c "$DIR"/config.ini 2>&1 | tee -a /tmp/polybar.log & disown
fi
