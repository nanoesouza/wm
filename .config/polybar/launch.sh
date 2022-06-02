#!/usr/bin/env bash
DIR="$HOME/.config/polybar"
HDMI=$(xrandr --query | grep 'HDMI1')

# Terminate already running bar instances
killall -q polybar

echo "---" | tee -a /tmp/polybar.log
polybar -q main -c "$DIR"/config.ini 2>&1 | tee -a /tmp/polybar.log & disown
