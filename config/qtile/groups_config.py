from libqtile.config import Group, Match, Key
from libqtile.lazy import lazy

groups = [
    Group(
        name="1",
        label="",
        matches=[
            Match(wm_class=[
                "Firefox"
            ])
        ],
    ),
    Group(
        name="2",
        label="",
        matches=[
            Match(wm_class=[
            ])
        ],
    ),
    Group(
        name="3",
        label="",
        matches=[
            Match(wm_class=[
            ])
        ],
    ),
    Group(
        name="4",
        label="ﯢ",
        matches=[
            Match(wm_class=[
            ])
        ],
    ),
    Group(
        name="5",
        label="",
        matches=[
            Match(wm_class=[
            ])
        ],
    ),
    Group(
        name="6",
        label="",
        matches=[
            Match(wm_class=[
            ])
        ],
    ),
    Group(
        name="7",
        label="",
        matches=[
            Match(wm_class=[
            ])
        ],
    ),
    Group(
        name="8",
        label="",
        matches=[
            Match(wm_class=[
                "TelegramDesktop",
                "whatsapp-nativefier-d40211",
                "discord"
            ])
        ],
    ),
    Group(
        name="9",
        label="",
        matches=[
            Match(wm_class=[
                "mpv"
            ])
        ],
    ),
    Group(
        name="0",
        label="",
        # matches=[
        #     Match(wm_class=[
        #         "music",
        #         "Spotify",
        #     ])
        # ],
    ),
]


def init_groups(keys, mod):
    for i in groups:
        keys.extend([
            # mod1 + letter of group = switch to group
            Key([mod], i.name, lazy.group[i.name].toscreen(toggle=False),
                desc="Switch to group {}".format(i.name)),

            # mod1 + shift + letter of group = switch to & move focused window to group
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name)),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ])
    return groups
