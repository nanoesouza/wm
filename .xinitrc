#!/bin/sh
wm=awesome
export XDG_CONFIG_HOME=/home/adriano.elias/.config

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#picom -f --experimental-backends &
#nitrogen --restore &
#dunst &
#setxkbmap br thinkpad &
#libinput-gestures-setup autostart start &
#rfkill unblock all &
#xsetroot -cursor_name left_ptr &
#~/.local/bin/dualmonitor 

if [ $wm = "qtile" ]; then
    qtile start
elif [ $wm = "awesome" ]; then
    exec awesome
elif [ $wm = "bspwm" ]; then
    exec bspwm
fi
