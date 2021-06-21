from Xlib import X, display
from Xlib.ext import randr
from libqtile import bar, widget
from libqtile.config import Screen

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

widget_defaults = dict(
    font='CaskaydiaCove Nerd Font',
    fontSize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                # Left
                widget.GroupBox(
                    fontsize=15,
                    hide_unused=True,
                    use_mouse_wheel=False,
                ),
                widget.Prompt(),

                widget.Spacer(),
                # Middle
                widget.Spacer(),

                # Left
                widget.Systray(),
                widget.Volume(
                    emoji=True,
                ),
                widget.Wlan(
                    interface='wlo1',
                    format='{essid} {percent:2.0%}',
                    disconnected_message="",
                ),
                widget.BatteryIcon(),
                widget.Clock(format='%I:%M %p'),
                widget.CurrentLayout(),
                widget.CurrentLayoutIcon(),
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
                        widget.GroupBox(
                            fontsize=25,
                            hide_unused=True,
                            use_mouse_wheel=False,
                        ),
                        widget.Prompt(),
                        widget.Spacer(),
                        widget.Clock(format='%I:%M %p'),
                        widget.CurrentLayoutIcon(),
                    ],
                    24,
                )
            )
        )


def init_screens():
    return screens
