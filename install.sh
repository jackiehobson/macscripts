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


# ~/.zmisc holds my scripts and misc files

mkdir ~/.zmisc

# installs files

cp ./scripts/* ~/.zmisc/
touch ~/.zmisc/lastupdated.dat

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

# if homebrew support is enabled then add homebrew supported script 

if test -f ./BREW.dat; then
	echo "~/.zmisc/updater.sh" >> ~/.zprofile
else
	echo ~/.zmisc/updater_nh.sh" >> ~/.zprofile
fi

ICLOUD=~/Library/Mobile\ Documents/com\~apple\~CloudDocs



# makes symlinks of .ssh, .gnupg, .config from iCloud storage
# but backs them up first and only if DOTFILES.dat exists in the repo

if test -f ./ICLOUD.dat; then

	echo "Copying .ssh, .gnupg, and .config to ~/.dotfiles.old..."
	mkdir ~/.dotfiles.old
	mv ~/.ssh ~/.config ~/.gnupg ~/.dotfiles.old

	echo "Making symlinks of .ssh, .gnupg and .config to icloud..."
	ln -s $ICLOUD/dotfiles/ssh ~/.ssh
	ln -s $ICLOUD/dotfiles/config ~/.config
	ln -s $ICLOUD/dotfiles/gnupg ~/.gnupg

fi
