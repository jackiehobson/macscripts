#!/bin/bash

# check of this file's last modification is older than 30 minutes

if test "`find ~/.zmisc/lastupdated.dat -mmin +30`"; then

# if it is, update homebrew and check for a macos software update

	brew update -v 
	brew upgrade -v
	softwareupdate -l

# touch the file so the next time the script is run the last update is logged

	touch ~/.zmisc/lastupdated.dat
fi
