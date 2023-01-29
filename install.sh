#!/bin/bash

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
echo "ICLOUD=~/Library/Mobile\ Documents/com\~apple\~CloudDocs" >> ~/.zprofile
echo "~/.zmisc/updater.sh" >> ~/.zprofile

ICLOUD=~/Library/Mobile\ Documents/com\~apple\~CloudDocs



# makes symlinks of .ssh, .gnupg, .config from iCloud storage
# but backs them up first

mkdir ~/.dotfiles.old
mv ~/.ssh ~/.config ~/.gnupg ~/.dotfiles.old

ln -s $ICLOUD/dotfiles/ssh ~/.ssh
ln -s $ICLOUD/dotfiles/config ~/.config
ln -s $ICLOUD/dotfiles/gnupg ~/.gnupg
