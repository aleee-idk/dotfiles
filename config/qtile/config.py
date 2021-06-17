from keys_config import *
from screens_config import *
from groups_config import *
from rules_config import *
from posixpath import expanduser
from typing import List, Match  # noqa: F401

from libqtile import bar, layout, widget, hook, extension
from libqtile import utils
from libqtile.config import Click, Drag, Group, Match, Key, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from pprint import pprint

import os
import subprocess


def volume_control(change: int):
    cmd = ''
    if change == 0:
        cmd = "pactl set-sink-mute 0 toggle"
    elif change > 0:
        cmd = f"pactl set-sink-volume 0 + {str(change)}%"
    else:
        cmd = f"pactl set-sink-volume 0 {str(change)}%"

    return cmd


mod = "mod4"
terminal = guess_terminal()

keys = init_keys(mod)
mouse = init_mouse(mod)

# Hooks


@hook.subscribe.startup
def autostart():
    subprocess.call([os.path.expanduser("~/.fehbg")])
    subprocess.call(["wal -n -R"])


groups = init_groups(keys, "mod4")

layout_theme = {
    "margin": 10
}

layouts = [
    # layout.Max(**layout_theme),
    # layout.Stack(num_stacks=2, **layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Columns(insert_position=1, **layout_theme),
    # layout.Matrix(**layout_theme),
    layout.MonadTall(**layout_theme),
    # layout.MonadWide(**layout_theme),
    # layout.RatioTile(**layout_theme),
    layout.Tile(master_lenth=3, **layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Zoomy(**layout_theme),
    layout.Floating(**layout_theme),
]


screens = init_screens()


dgroups_key_binder = None
dgroups_app_rules = init_rules()  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = True
cursor_warp = True
# floating_layout = layout.Floating(float_rules=[
#     # Run the utility of `xprop` to see the wm class and name of an X client.
#     Match(wm_class='confirm'),
#     Match(wm_class='confirmreset'),  # gitk
#     Match(wm_class='dialog'),
#     Match(wm_class='download'),
#     Match(wm_class='error'),
#     Match(wm_class='file_progress'),
#     Match(wm_class='makebranch'),  # gitk
#     Match(wm_class='maketag'),  # gitk
#     Match(wm_class='notification'),
#     Match(wm_class='splash'),
#     Match(wm_class='ssh-askpass'),  # ssh-askpass
#     Match(wm_class='toolbar'),
#     Match(wm_class='Thunar'),
#     Match(wm_class='Godot'),
#     Match(wm_class='Arandr'),
#     Match(wm_class='Blueman-manager'),
#     Match(wm_class='files'),
#     Match(wm_class='vimiv'),
#     Match(title='branchdialog'),  # gitk
#     Match(title='pinentry'),  # GPG key password entry
# ])
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
