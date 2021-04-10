from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook, extension
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from Xlib import X, display
from Xlib.ext import randr
from pprint import pprint

import os
import subprocess

d = display.Display()
s = d.screen()
r = s.root
res = r.xrandr_get_screen_resources()._data

# Dynamic multiscreen! (Thanks XRandr)
num_screens = 0
for output in res['outputs']:
    print("Output %d:" % (output))
    mon = d.xrandr_get_output_info(output, res['config_timestamp'])._data
    print("%s: %d" % (mon['name'], mon['num_preferred']))
    if mon['num_preferred']:
        num_screens += 1

print("%d screens found!" % (num_screens))

mod = "mod4"
terminal = guess_terminal()

keys = [
    # test
    Key([mod], 'p', lazy.run_extension(extension.CommandSet(
        commands={
            '1': 'echo 1',
            '2': 'echo 2',
            '3': 'echo 3',
        }
    ))),

    # Movement
    Key([mod], "h", lazy.layout.left(),
        desc="Move focus down in stack pane"),
    Key([mod], "j", lazy.layout.down(),
        desc="Move focus down in stack pane"),
    Key([mod], "k", lazy.layout.up(),
        desc="Move focus up in stack pane"),
    Key([mod], "l", lazy.layout.right(),
        desc="Move focus down in stack pane"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move focus down in stack pane"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move focus down in stack pane"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),
        desc="Move focus up in stack pane"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move focus down in stack pane"),

    Key([mod, "mod1"], "h", lazy.layout.flip_left(),
        desc="Resize left in stack pane"),
    Key([mod, "mod1"], "j", lazy.layout.flip_down(),
        desc="Resize down in stack pane"),
    Key([mod, "mod1"], "k", lazy.layout.flip_up(),
        desc="Resize up in stack pane"),
    Key([mod, "mod1"], "l", lazy.layout.flip_right(),
        desc="Resize right in stack pane"),

    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Resize left in stack pane"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Resize down in stack pane"),
    Key([mod, "control"], "k", lazy.layout.grow_up(),
        desc="Resize up in stack pane"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Resize right in stack pane"),

    Key([mod], "i", lazy.layout.grow()),
    Key([mod], "m", lazy.layout.shrink()),
    Key([mod], "m", lazy.layout.maximize()),
    Key([mod], "n", lazy.layout.normalize()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack"),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(),
        desc="Swap panes of split stack"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),

    # Run stuff
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "d", lazy.spawn('rofi -show drun -theme themes/custom'),
        desc="launch app launcher"),
    Key([mod, 'shift'], "d", lazy.spawn(
        'rofi -show run -theme themes/custom'), desc="launch app launcher"),
    Key(['mod1'], "Tab", lazy.spawn(
        'rofi -show window -theme themes/custom'), desc="launch app launcher"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),

    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    # Destroy stuff
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),

    # Laptop keys
    Key(
        [], "XF86AudioMute",
        lazy.spawn("pactl set-sink-mute 0 toggle")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume 0 -5%")
    ),
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume 0 +5%")
    ),
    Key(
        [], "XF86MonBrightnessUp",
        lazy.spawn("xbacklight -inc 1")
    ),
    Key(
        [], "XF86MonBrightnessDown",
        lazy.spawn("xbacklight -dec 1")
    ),
]

# Hooks


@hook.subscribe.startup
def autostart():
    home = os.path.expanduser('~/.config/master.sh')
    subprocess.call([home])


groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

layout_theme = {
    "margin": 10
}

layouts = [
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2, **layout_theme),
    # layout.Bsp(**layout_theme),
    layout.Columns(insert_position=1, **layout_theme),
    # layout.Matrix(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Tile(master_lenth=3, **layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Zoomy(**layout_theme),
]

widget_defaults = dict(
    font='sans',
    fontSize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(),
                widget.CurrentLayout(),
                widget.GroupBox(
                    fontsize=12,
                    hide_unused=True,
                    use_mouse_wheel=False,
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff")
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Spacer(),
                # widget.Mpd2(),
                widget.Pomodoro(),
                widget.Sep(),
                widget.Systray(),
                # widget.GmailChecker(),
                widget.CheckUpdates(),
                widget.DF(
                    warn_space=15,
                    format='{p} [{f}{m}/{s}{m}|{r:.0f}%]'
                ),
                widget.Volume(emoji=True),
                widget.Wlan(interface='wlo1', format='{essid} {percent:2.0%}'),
                widget.Clock(format='%I:%M %p'),
                widget.QuickExit(),
            ],
            24,
        ),
    ),
]

if num_screens > 1:
    for m in range(num_screens - 1):
        screens.append(
            Screen(
                top=bar.Bar(
                    [
                        widget.CurrentLayoutIcon(),
                        widget.CurrentLayout(),
                        widget.GroupBox(
                            fontsize=12,
                            hide_unused=True,
                            use_mouse_wheel=False,
                        ),
                        widget.Prompt(),
                        widget.WindowName(),
                        widget.Chord(
                            chords_colors={
                                'launch': ("#ff0000", "#ffffff")
                            },
                            name_transform=lambda name: name.upper(),
                        ),
                    ],
                    24,
                )
            )
        )

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
