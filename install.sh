# ~/.zmisc holds my scripts and misc files

mkdir ~/.zmisc

# installs files

cp ./scripts/* ~/.zmisc/
touch ~/.zmisc/lastupdated.dat

# installs ~/.zmisc to $PATH and sets the updater script to run

echo 'PATH=$PATH":~/.zmisc"' >> ~/.zprofile
echo '~/.zmisc/updater.sh' >> ~/.zprofile
