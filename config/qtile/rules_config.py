from libqtile.config import Rule, Match


def init_rules():
    rules = [
        # Floating
        Rule(
            Match(
                wm_type=[
                    "Arandr",
                    "Blueman-manager",
                    "Godot",
                    "Gpick",
                    "Kruler",
                    "MessageWin",  # kalarm.
                    "Sxiv",
                    "Thunar",
                    # Needs a fixed window size to avoid fingerprinting by screen size.
                    "Tor Browser",
                    "Wpa_gui",
                    "branchdialog",
                    "confirm",
                    "confirmreset",
                    "dialog",
                    "download",
                    "error",
                    "file_progress",
                    "files",  # Custom Class for some terminals
                    "makebranch",
                    "maketag",
                    "notification",
                    "pinentry",
                    "splash",
                    "sshaskpass"
                    "toolbar",
                    "veromix",
                    "vimiv",  # image Viewer
                    "xtightvncviewer",
                ],
                wm_instance_class=[
                    "DTA",  # Firefox addon DownThemAll.
                    "copyq",  # Includes session name in class.
                    "pinentry",
                    "Devtools",  # Firefox devtools
                ],
                role=[
                    "AlarmWindow",  # Thunderbird's calendar.
                    "ConfigManager",  # Thunderbird's about:config.
                    # e.g. Google Chrome's (detached) Developer Tools.
                    "pop-up",
                ]
            ),
            float=True
        ),

        # On Specific Group

        # Group 1
        Rule(
            Match(
                wm_class=[
                ]
            ),
            group=1
        ),

        # Group 2
        Rule(
            Match(
                wm_class=[
                ]
            ),
            group=2
        ),

        # Group 3
        Rule(
            Match(
                wm_class=[
                ]
            ),
            group=3
        ),

        # Group 4
        Rule(
            Match(
                wm_class=[
                ]
            ),
            group=4
        ),

        # Group 5
        Rule(
            Match(
                wm_class=[
                ]
            ),
            group=5
        ),

        # Group 6
        Rule(
            Match(
                wm_class=[
                ]
            ),
            group=6
        ),

        # Group 7
        Rule(
            Match(
                wm_class=[
                ]
            ),
            group=7
        ),

        # Group 8
        Rule(
            Match(
                wm_class=[
                ]
            ),
            group=8
        ),

        # Group 9
        Rule(
            Match(
                wm_class=[
                ]
            ),
            group=9
        ),

        # Group 0
        Rule(
            Match(
                wm_class=[
                    "music",
                    "Spotify",
                ]
            ),
            group="0"
        ),
    ]
    return rules
