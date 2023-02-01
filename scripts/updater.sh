#!/bin/bash


# make it so ctrl-c exits the program and resets the update timer

stty -echoctl
trap ctrl_c INT
function ctrl_c() {
	touch ~/.zmisc/lastupdated.dat
	echo
	echo "Exiting updates..."
	echo
	exit 0
}

# check of this file's last modification is older than 30 minutes

if test "`find ~/.zmisc/lastupdated.dat -mmin +30`"; then

	# check if there's internet
	touch ~/.zmisc/checkinternet.dat

	while true; do

		# check if we can ping 9.9.9.9, if so continue the script	

		if $( (( $(ping -c 1 9.9.9.9 > /dev/null ; echo $?) < 1 )) ); then
			break
		fi

		# otherwise, if we can't ping 9.9.9.9 then try for 5 minutes then quit
	
		if test "`find ~/.zmisc/checkinternet.dat -mmin +5`"; then
			echo "No internet in the past 5 minutes."
			exit 1
		fi

	done

	# delete the file so next time it doesn't just quit

	rm ~/.zmisc/checkinternet.dat

	# update homebrew and check for a macos software update

	brew update -v 
	brew upgrade -v
	echo
	softwareupdate -l

	# touch the file so the next time the script is run the last update is logged

	touch ~/.zmisc/lastupdated.dat
fi
