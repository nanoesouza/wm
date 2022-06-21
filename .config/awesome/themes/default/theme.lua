---------------------------
-- Default awesome theme --
---------------------------

local gears = require("gears")
--local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local watch = require("awful.widget.watch")


local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

-- Variable Definitions

theme.font          = "JetBrains Mono Nerd Font ExtraBold 9"

theme.bg_normal     = "#15151599"
theme.bg_focus      = "#20212CD9"
theme.bg_urgent     = "#ff7a93"
theme.bg_minimize   = "#DDDADAFF"
theme.bg_systray    = theme.bg_normal
theme.fg_normal     = "#E8E3E3"
theme.fg_focus      = "#acb0d0"
theme.fg_urgent     = "#E8E3E3"
theme.fg_minimize   = "#acb0d0"
theme.taglist_fg_focus = "#E8E3E3"
theme.taglist_fg_occupied = "#8D8E92"
theme.taglist_fg_empty    = "#585353"
theme.taglist_spacing     = 5
theme.useless_gap   = 5
theme.border_width  = 2
theme.menu_height = 20
theme.menu_width  = 140
theme.border_normal = "#B66467"
theme.border_focus  = "#f38ba8"
theme.border_marked = "#ff7a93"
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.wallpaper = "/home/adriano.elias/images/walls/catppucin-walls/landscapes/shaded_landscape.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Separator
local separator = wibox.widget.textbox("  ")
local separator1 = wibox.widget.textbox("|")

-- Clock Widget
local wdg_clock = wibox.widget.textclock()

-- Systray Widget
local wdg_systray = wibox.widget.systray()
wdg_systray:set_base_size(15)

-- VPN widget
local cmd_vpn = "/home/adriano.elias/.local/bin/vpn_status"
local wdg_vpn = awful.widget.watch(cmd_vpn,2)
wdg_vpn:buttons(gears.table.join(
    wdg_vpn:buttons(),
    awful.button({}, 1, nil, function()
        awful.spawn("sudo openvpn --bind --cd '/home/adriano.elias/docs/VPN' --config 'MGA.ovpn'")
    end),
    awful.button({}, 3, nil, function()
        awful.spawn("sudo killall openvpn")
    end)
))

--
local wdg_redshift = wibox.widget.textbox(" ")

-- Mic widget
local cmd_mic = "/home/adriano.elias/.local/scripts/micstatus"
local wdg_mic = awful.widget.watch(cmd_mic,1)
wdg_mic:buttons(gears.table.join(
    wdg_mic:buttons(),
    awful.button({}, 1, nil, function()
        awful.spawn("/home/adriano.elias/.local/bin/micvolume mute")
    end),
    awful.button({}, 3, nil, function()
        awful.spawn("pavucontrol")
    end),
    awful.button({}, 4, nil, function()
        awful.spawn("/home/adriano.elias/.local/bin/micvolume up")
    end),
    awful.button({}, 5, nil, function()
        awful.spawn("/home/adriano.elias/.local/bin/micvolume down")
    end)
))

-- Volume Widget
local cmd_vol = "/home/adriano.elias/.local/scripts/volstatus"
local wdg_vol = awful.widget.watch(cmd_vol,1)
wdg_vol:buttons(gears.table.join(
    wdg_vol:buttons(),
    awful.button({}, 1, nil, function()
        awful.spawn("/home/adriano.elias/.local/bin/changevolume mute")
    end),
    awful.button({}, 3, nil, function()
        awful.spawn("pavucontrol")
    end),
    awful.button({}, 4, nil, function()
        awful.spawn("/home/adriano.elias/.local/bin/changevolume up")
    end),
    awful.button({}, 5, nil, function()
        awful.spawn("/home/adriano.elias/.local/bin/changevolume down")
    end)
))


-- Brightness Widget
local cmd_bright = "/home/adriano.elias/.local/scripts/bright_status"
local wdg_bright = awful.widget.watch(cmd_bright,1)
wdg_bright:buttons(gears.table.join(
    wdg_bright:buttons(),
    awful.button({}, 1, nil, function()
        awful.spawn("redshift -P -O 4000")
    end),
    awful.button({}, 3, nil, function()
        awful.spawn("redshift -x")
    end),
    awful.button({}, 4, nil, function()
        awful.spawn("/home/adriano.elias/.local/bin/brightness up")
    end),
    awful.button({}, 5, nil, function()
        awful.spawn("/home/adriano.elias/.local/bin/brightness down")
    end)
))

-- Spotify Widget
local wdg_spotify = require("widgets.spotify.spotify"){
    font = theme.font,
    play_icon = '/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg',
    pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg',
    dim_when_paused = true,
    dim_opacity = 0.5,
    max_length = -1,
    show_tooltip = true
}

-- Wireless
local cmd_wifi = "/home/adriano.elias/.local/scripts/wifi_status"
local wdg_wifi = awful.widget.watch(cmd_wifi,5)
wdg_wifi:buttons(gears.table.join(
    wdg_wifi:buttons(),
    awful.button({}, 1, nil, function()
        awful.spawn("wifimenu")
    end)
))

-- Battery Widget
local wdg_battery = require("widgets.battery"){
    ac = "AC",
    adapter = "BAT0",
    ac_prefix = " ",
    battery_prefix = {
        { 25, "  "},
        { 50, "  "},
        { 75, "  "},
        {100, "  "}
    },
    percent_colors = {
        { 25, "red"   },
        { 50, "#E8E3E3"},
        {999, "#E8E3E3" },
    },
    listen = true,
    timeout = 10,
    widget_text = "${color_on}${AC_BAT}${percent}%${color_off}",
    tooltip_text = "Battery ${state}${time_est}\nCapacity: ${capacity_percent}%",
    alert_threshold = 5,
    alert_timeout = 0,
    alert_title = "Low battery !",
    alert_text = "${AC_BAT}${time_est}"
}

-- Create Wibar
function theme.at_screen_connect(s)
    -- Each screen has its own tag table.
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.stack,
        {
            layout = wibox.layout.align.horizontal,
            expand = none,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                spacing = 3,
                s.mylayoutbox,
                separator,
                s.mytaglist,
                separator,
                wdg_spotify,
            },
            { -- Center Widgets
                layout = wibox.container.place,
                valign = "center",
                halign = "center",
            },
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                spacing = 5,
                wdg_bright,
                separator1,
                wdg_vpn,
                separator1,
                wdg_battery,
                separator1,
                wdg_wifi,
                separator1,
                wdg_mic,
                separator1,
                wdg_vol,
                separator1,
                wdg_clock,
            }
        },
    }
end
return theme
