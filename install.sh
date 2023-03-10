#!/bin/bash

#    install.sh - installs updater.sh or updater_nh.sh and arranges dotfiles
#    Copyright (C) 2023 Jackie Hobson

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.


function ynprompt {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0 ;;
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}


# ~/.zmisc holds my scripts and misc files

mkdir ~/.zmisc

# installs files

cp ./updater.sh ~/.zmisc/
touch –t 8804152240 ~/.zmisc/lastupdated.dat

# installs ~/.zmisc to $PATH and sets the updater script to run
# and adds the macos software update/upgrade aliases

echo "" >> ~/.zprofile
echo "# macscripts settings" >> ~/.zprofile
echo "" >> ~/.zprofile
echo 'PATH=$PATH":~/.zmisc"' >> ~/.zprofile
echo "alias update='softwareupdate -l'" >> ~/.zprofile
echo "alias upgrade='sudo softwareupdate -iar --agree-to-license'" >> ~/.zprofile

# adds iCloud directory variable

echo "ICLOUD=~/Library/Mobile\ Documents/com\~apple\~CloudDocs" >> ~/.zprofile

ICLOUD=~/Library/Mobile\ Documents/com\~apple\~CloudDocs

# Install update support

if ynprompt "Enable homebrew updates?"; then
    echo "1" > ~/.zmisc/brew.dat
fi

if ynprompt "Enable pip updates?"; then
    echo "1" > ~/.zmisc/pip.dat
fi

if ynprompt "Enable macos updates?"; then
    echo "1" > ~/.zmisc/mac.dat
fi

# makes symlinks of .ssh, .gnupg, .config from iCloud storage
# # but backs them up first and only if DOTFILES.dat exists in the repo

if ynprompt "Enable iCloud for .ssh, .gnupg, & .config?"; then

	echo "Copying .ssh, .gnupg, and .config to ~/.dotfiles.old..."
	mkdir ~/.dotfiles.old
	mkdir $ICLOUD/dotfiles
	cp ~/.ssh $ICLOUD/dotfiles/ssh
	cp ~/.gnupg $ICLOUD/dotfiles/gnupg
	cp ~/.config $ICLOUD/dotfiles/gnupg
	mv ~/.ssh ~/.config ~/.gnupg ~/.dotfiles.old
	echo "Making symlinks of .ssh, .gnupg and .config to iCloud..."
	ln -s $ICLOUD/dotfiles/ssh ~/.ssh
	ln -s $ICLOUD/dotfiles/config ~/.config
	ln -s $ICLOUD/dotfiles/gnupg ~/.gnupg

fi
