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
