#!/bin/bash

#    updater_nh.sh - checks for mac updates
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

	# check for a macos software update

	softwareupdate -l

	# touch the file so the next time the script is run the last update is logged

	touch ~/.zmisc/lastupdated.dat
fi
