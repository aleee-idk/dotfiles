# /usr/bin/env bash

# This options can be investigated with dconf-editor

for i in {1..10}; do
    desktop=$i

     [[ $i == 10 ]] && key='0' || key="$i"

    # Reset Switch - Open taskbar app
    [[ $i != 10 ]] && gsettings set org.gnome.shell.keybindings "switch-to-application-$desktop" []
    
    # Move Stuff to workspace
    gsettings set org.gnome.desktop.wm.keybindings "move-to-workspace-$desktop" "['<Shift><Super>$key']"

    # Focus
    gsettings set org.gnome.desktop.wm.keybindings "switch-to-workspace-$desktop" "['<Super>$key']"
done

# Reset sme keys
gsettings set org.gnome.desktop.wm.keybindings switch-group []
gsettings set org.gnome.desktop.wm.keybindings switch-group-backward []
gsettings set org.gnome.mutter.keybindings switch-monitor []

# Above_Tab is | in latin american layout
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last "['<Super>Above_Tab']"

## Windows configuration
gsettings set org.gnome.desktop.wm.keybindings close "['<Shift><Super>q']"

gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>z']"

gsettings set org.gnome.desktop.wm.keybindings toggle-on-all-workspaces "['<Super>p']"
