import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List 

home = os.path.expanduser('~')
sup = "mod4"
alt = "mod1"
terminal = "alacritty"
browser = "brave"

@hook.subscribe.startup
def start_once():
    subprocess.call([home + '/.config/qtile/autostart.sh'])


keys = [
    #Launch Programs
    Key([sup], "Return", lazy.spawn(terminal), desc="Launches My Terminal"),
    Key([sup], "q", lazy.spawn(browser), desc="Launches My Browser"),
    Key([sup, "shift"], "p", lazy.spawn("bwmenu"), desc="Bitwarden Rofi Menu"),
    Key([alt], "Tab", lazy.spawn("rofi -show window"), desc= "Alternate between windows"),
    Key([sup], "e", lazy.spawn("thunar"), desc="File Explorer"),

    # Rofi Menus
    KeyChord([sup], "d", [
        Key([], "d", lazy.spawn("rofi -show drun"), desc="Launcher Menu"),
        Key([], "c", lazy.spawn("configfiles"), desc="Edit configuration file"),
        Key([], "w", lazy.spawn("wifimenu"), desc="Launch Wifi menu"),
        Key([], "p", lazy.spawn("powermenu"), desc="Launch power menu"),
        Key([], "y", lazy.spawn("meu-amor"), desc="Dia dos namorados"),
    ]),

    #Volume and Media
    Key([sup], "x", lazy.spawn("betterlockscreen -l dimblur"), desc="Lockscreen"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("changevolume up"), desc="Volume up"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("changevolume down"), desc="Volume down"),
    Key([], "XF86AudioMute", lazy.spawn("changevolume mute"), desc="volume muted"),
    Key([], "XF86AudioMicMute", lazy.spawn("micvolume mute"), desc="microphone mute"),
    Key([], "XF86Tools", lazy.spawn("micvolume mute"), desc="microphone mute"),
    Key([sup], "XF86AudioRaiseVolume", lazy.spawn("micvolume up"), desc="microphone volume up"),
    Key([sup], "XF86AudioLowerVolume", lazy.spawn("micvolume down"), desc="microphone volume up"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightness up"), desc="brigthness up"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightness down"), desc="brigthness down"),

    #tools
    Key([sup, "shift"], "s", lazy.spawn("flameshot gui"), desc="screenshot"),

    #Windows Manipulations
    Key([sup], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([sup], "l", lazy.layout.right(), desc="Move focus to right"),

    Key([sup], "j", lazy.layout.down(), desc="Move focus down"),
    Key([sup], "k", lazy.layout.up(), desc="Move focus up"),
    Key([sup], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([sup, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([sup, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([sup, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([sup, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([sup, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([sup, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([sup, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([sup, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([sup], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([sup, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    Key([sup], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([sup], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([sup, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([sup, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([sup], "r", lazy.spawn("rofi -show drun"), desc="Spawn a command using a prompt widget"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key([sup], i.name, lazy.group[i.name].toscreen(), desc="Switch to group {}".format(i.name)),
            Key([sup, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True), desc="Switch to & move focused window to group {}".format(i.name)),
        ]
    )

layout_theme = {"border_width": 1,
                "margin": 5,
                "border_focus": "787c99",
                "border_normal": "32344a",
                "border_focus_stack": "787c99"
                }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Columns(**layout_theme),
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2),
    #layout.RatioTile(**layout_theme),
    layout.Floating(**layout_theme)
]

#COLORING
colors = [["#16161e", "#16161e"],
          ["#20212C", "#20212C"],
          ["#acb0d0", "#acb0d0"],
          ["#ff7a93", "#ff7a93"],
          ["#CACACE", "#CACACE"],
          ["#787c99", "#787c99"],
          ["#444b6a", "#444b6a"],
          ["#32344a", "#32344a"],
          ["#cdd6f4", "#cdd6f4"],
          ["#bac2de", "#bac2de"]]

#WIDGETS / BAR
widget_defaults = dict(
    font="JetBrains Mono Nerd Font ExtraBold",
    fontsize=12,
    padding=10,
    background=colors[0],
    foreground=colors[2],
)
extension_defaults = widget_defaults.copy()

screens = [Screen(top=bar.Gap(20)), Screen(top=bar.Gap(20))]


#def init_widgets_list1():
#    widgets_list1 = [
#        widget.CurrentLayoutIcon(),
#        widget.GroupBox(
#            padding = 3,
#        ),
#        widget.Spacer(),
#        widget.Clock(
#            format = " %a, %d %B |  %H:%M"
#        ),
#        widget.Spacer(),
#        widget.TextBox(
#            text = "",
#            padding=3,
#            mouse_callbacks = {
#                'Button1': lambda: qtile.cmd_spawn("redshift -P -O 4000"),
#                'Button3': lambda: qtile.cmd_spawn("redshift -x"),
#            },
#        ),
#        widget.Backlight(
#            backlight_name = "intel_backlight",
#            padding=3,
#            format = "{percent:2.0%}",
#        ),
#        widget.Sep(),
#        widget.GenPollText(
#            update_interval = 5,
#            func = lambda: subprocess.check_output(home + "/.local/scripts/vpn-openvpn-status.sh").decode("utf-8"),
#            mouse_callbacks = {
#                'Button1': lambda: qtile.cmd_spawn("sudo openvpn --bind --cd "+ home + "/docs/VPN' --config 'MGA.ovpn'"),
#                'Button3': lambda: qtile.cmd_spawn("sudo killall openvpn"), 
#            },
#        ),
#        widget.Sep(),
#        widget.Wlan(
#            format = "  {essid}",
#            interface = "wlan0",
#            mouse_callbacks = {
#                'Button1': lambda: qtile.cmd_spawn("wifimenu"),
#            },
#        ),
#        widget.Sep(),
#        widget.Battery(
#            format = "{char} {percent:2.0%}",
#            full_char = ' ',
#            discharge_char = ' ',
#            charge_char = '',
#            emtpy_char = ' ',
#            unknown_char = ' ',
#            update_interval = '1',
#        ),
#        widget.Sep(),
#        widget.GenPollText(
#            update_interval = 3,
#            func = lambda: subprocess.check_output(home + "/.local/scripts/micstatus").decode("utf-8"),
#            mouse_callbacks = {
#                'Button1': lambda: qtile.cmd_spawn("micvolume mute"),
#                'Button3': lambda: qtile.cmd_spawn("pavucontrol"), 
#            },
#        ),
#        widget.Volume(
#            emoji = "True",
#            padding=3,
#        ),
#        widget.Volume(
#            padding=3,
#            mouse_callbacks = {
#                'Button3': lambda: qtile.cmd_spawn("pavucontrol"),
#            },
#            volume_up_command = 'changevolume up',
#            volume_down_command = 'changevolume down',
#            mute_command = 'changevolume mute',
#        ),
#        widget.Sep(
#            padding = 10,    
#        ),
#        widget.Systray(),
#    ]
#
#    return widgets_list1
#
#def init_widgets_list2():
#    widgets_list2 = [
#        widget.CurrentLayoutIcon(),
#        widget.GroupBox(
#            padding = 3,
#        ),
#        widget.Spacer(),
#        widget.Clock(
#            format = " %a, %d %B |  %H:%M"
#        ),
#        widget.Spacer(),
#        widget.TextBox(
#            text = "",
#            padding=3,
#            mouse_callbacks = {
#                'Button1': lambda: qtile.cmd_spawn("redshift -P -O 4000"),
#                'Button3': lambda: qtile.cmd_spawn("redshift -x"),
#            },
#        ),
#        widget.Sep(),
#        widget.GenPollText(
#            update_interval = 5,
#            func = lambda: subprocess.check_output(home + "/.local/scripts/vpn-openvpn-status.sh").decode("utf-8"),
#            mouse_callbacks = {
#                'Button1': lambda: qtile.cmd_spawn("sudo openvpn --bind --cd '/home/adriano.elias/docs/VPN' --config 'MGA.ovpn'"),
#                'Button3': lambda: qtile.cmd_spawn("sudo killall openvpn"), 
#            },
#        ),
#        widget.Sep(),
#        widget.Wlan(
#            format = "  {essid}",
#            interface = "wlan0",
#            mouse_callbacks = {
#                'Button1': lambda: qtile.cmd_spawn("wifimenu"),
#            },
#        ),
#        widget.Sep(),
#        widget.Battery(
#            format = "{char} {percent:2.0%}",
#            full_char = ' ',
#            discharge_char = ' ',
#            charge_char = '',
#            emtpy_char = ' ',
#            unknown_char = ' ',
#            update_interval = '1',
#        ),
#        widget.Sep(),
#        widget.GenPollText(
#            update_interval = 3,
#            func = lambda: subprocess.check_output(home + "/.local/scripts/micstatus").decode("utf-8"),
#            mouse_callbacks = {
#                'Button1': lambda: qtile.cmd_spawn("micvolume mute"),
#                'Button3': lambda: qtile.cmd_spawn("pavucontrol"), 
#            },
#        ),
#        widget.Volume(
#            emoji = "True",
#            padding=3,
#        ),
#        widget.Volume(
#            padding=3,
#            mouse_callbacks = {
#                'Button3': lambda: qtile.cmd_spawn("pavucontrol"),
#            },
#            volume_up_command = 'changevolume up',
#            volume_down_command = 'changevolume down',
#            mute_command = 'changevolume mute',
#        ),
#        widget.Sep(
#            padding = 10,    
#        ),
#    ]
#
#    return widgets_list2
#
#def init_widgets_screen1():
#    widgets_screen1 = init_widgets_list1()
#    return widgets_screen1
#    
#def init_widgets_screen2():
#    widgets_screen2 = init_widgets_list2()
#    return widgets_screen2 
#
#def init_screens():
#    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=0.6, size=20)),
#            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=0.6, size=20))]
#
#if __name__ in ["config", "__main__"]:
#    screens = init_screens()
#    widgets_list1 = init_widgets_list1()
#    widgets_list2 = init_widgets_list2()    
#    widgets_screen1 = init_widgets_screen1()
#    widgets_screen2 = init_widgets_screen2()

mouse = [
    Drag([sup], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([sup], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([sup], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True

wl_input_rules = None
wmname = "LG3D"
