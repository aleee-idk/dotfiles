#!/usr/bin/python3
from sys import argv

"""
This script will be called each time a window is manage by bspwm, it will
receive the following arguments: window ID, class name, instance name, and
intermediate consequences. 

This script have to print to stdout the key/value
defined in `bspc rule` command
"""

win_id = argv[1] if len(argv) >= 2 else ""
win_class = argv[2] if len(argv) >= 3 else ""
win_instance = argv[3] if len(argv) >= 4 else ""
consequences = argv[4] if len(argv) >= 5 else ""

import subprocess

subprocess.run(["notify-send", win_class])

"""
    App dictionary structure
    NOTE: "xprop", "properties" and "flags" are needed, but their content is
    optional, can be all of the below or none of it.

    "app": {
        "xprop": "class_name" | "instance_name" | "name",
        "properties": {
            "monitor"   : "MONITOR_SEL",
            "desktop"   : "DESKTOP_SEL",
            "state"     : "tiled" | "pseudo-tiled" | "floating" | "fullscreen",
            "layer"     : "BELOW" | "NORMAL" | "ABOVE",
            "split_dir" : "north" | "west" | "south" | "east",
            "rectangle" : "WxH+X+Y",
        },
        "flags": {
            "hidden"  : "on" | "off",
            "sticky"  : "on" | "off",
            "private" : "on" | "off",
            "locked"  : "on" | "off",
            "marked"  : "on" | "off",
            "center"  : "on" | "off",
            "follow"  : "on" | "off",
            "manage"  : "on" | "off",
            "focus"   : "on" | "off",
            "border"  : "on" | "off",
        },
    },
"""

windows_rules = {
    "firefox": {
        "xprop": "class_name",
        "properties": {
            "desktop": "1",
        },
        "flags": {},
    },
    "qutebrowser": {
        "xprop": "class_name",
        "properties": {
            "desktop": "2",
        },
        "flags": {},
    },
    "steam": {
        "xprop": "class_name",
        "properties": {
            "desktop": "5",
        },
        "flags": {},
    },
    "steam_app_*": {
        "xprop": "class_name",
        "properties": {
            "desktop": "5",
        },
        "flags": {"fullscreen": "on"},
    },
    "Signal": {
        "xprop": "class_name",
        "properties": {
            "desktop": "8",
        },
        "flags": {},
    },
    "discord": {
        "xprop": "class_name",
        "properties": {
            "desktop": "8",
        },
        "flags": {},
    },
    "mpv": {
        "xprop": "class_name",
        "properties": {
            "desktop": "9",
        },
        "flags": {},
    },
    "Spotify": {
        "xprop": "class_name",
        "properties": {
            "desktop": "10",
        },
        "flags": {},
    },
    "Thunar": {
        "xprop": "class_name",
        "properties": {"state": "floating"},
        "flags": {},
    },
}

window = None
rule_string = ""
if win_class:
    # filter only class name rules
    filter_rules = {
        key: value
        for key, value in windows_rules.items()
        if value["xprop"] == "class_name"
    }

    if win_class in filter_rules:
        window = filter_rules[win_class]

elif win_instance:
    # filter only instance rules
    filter_rules = {
        key: value
        for key, value in windows_rules.items()
        if value["xprop"] == "instance_name"
    }

    if win_class in filter_rules:
        window = filter_rules[win_instance]

if not window:
    exit()

for prop_name, prop_value in window["properties"].items():
    rule_string += f"{prop_name}={prop_value} "

for flag_name, flag_value in window["flags"].items():
    rule_string += f"{flag_name}={flag_value}"

print(rule_string)
