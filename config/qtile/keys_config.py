from posixpath import expanduser
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import os

terminal = guess_terminal()


def init_keys(mod):
    keys = [
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
        Key([mod], "d", lazy.spawn(os.path.expanduser('~/.config/rofi/launchers/misc/launcher.sh')),
            desc="launch app launcher"),
        Key([mod, 'shift'], "d", lazy.spawn(
            'rofi -show run -theme themes/custom'), desc="launch app launcher"),
        Key(['mod1'], "Tab", lazy.spawn(
            'rofi -show window -theme themes/custom'), desc="launch app launcher"),
        # Key([mod], "r", lazy.spawncmd(),
        #     desc="Spawn a command using a prompt widget"),

        Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

        # Destroy stuff
        Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
        Key([mod, "shift"], "r", lazy.restart(), desc="Restart qtile"),
        # Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),

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
    return keys


def init_mouse(mod):
    # Drag floating layouts.
    mouse = [
        Drag([mod], "Button1", lazy.window.set_position_floating(),
             start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(),
             start=lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front())
    ]
    return mouse
