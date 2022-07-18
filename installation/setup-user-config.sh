#!/usr/bin/env bash

function install_pkg() {
	sudo dnf install "$1" -y
}

##### User Config #####


##### Especial Apps #####

## Oh my zsh ##

$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


## Lazygit ## 

# Add to package repositories
sudo dnf copr enable atim/lazygit -y


## Fix NPM global packages ## 

wget -O- https://raw.githubusercontent.com/glenpike/npm-g_nosudo/master/npm-g-nosudo.sh | sh

## install lunarvim ##

bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

##### install stuff #####

for package in "${packages[@]}"; do
	install_pkg $package	
done

##### Create Softlinks #####

$HOME/dotfiles/installation/create_softlinks.sh

##### Figlet Fonts #####

git clone https://github.com/xero/figlet-fonts.git /tmp/figlet/
sudo mkdir -p /usr/share/figlet/fonts
sudo cp /tmp/figlet/* /usr/share/figlet/fonts/

##### Enable Flatpack #####
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
