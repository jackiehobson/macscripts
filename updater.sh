#!/bin/bash

#    updater.sh - updates homebrew + packages and checks for mac updates
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

# Make sure lock file exists so multiple updates can't run at the same time

LOCKFILE=~/.zmisc/updatelock.dat
touch $LOCKFILE

# Color codes for error messages

RED='\033[0;31m'
NOCOLOR='\033[0m'

# Make it so ctrl-c exits the program and resets the update timer

stty -echoctl
trap ctrl_c INT

function ctrl_c() {
	touch ~/.zmisc/lastupdated.dat
    echo "0" > $LOCKFILE
	echo
	echo -e "${RED}[!]${NOCOLOR} Exiting updates..."
	echo
	exit 0
}

# Check if there's an internet connection

function inet() {

    touch ~/.zmisc/checkinternet.dat

	while true; do

		# Check if we can ping 1.1.1.1, if so continue the script

		if $( (( $(ping -c 1 1.1.1.1 > /dev/null ; echo $?) < 1 )) ); then
			break
		fi

		# Otherwise, if we can't ping 1.1.1.1 then try for 5 minutes then quit

		if test "`find ~/.zmisc/checkinternet.dat -mmin +5`"; then
			echo "No internet in the past 5 minutes."
			exit 1
		fi

	done

	# Delete the file so next time it doesn't just quit

	rm ~/.zmisc/checkinternet.dat

}

function pipup() {
    if grep -q 1 ~/.zmisc/pip.dat; then
        pip --disable-pip-version-check list --outdated --format=json | python3 -c "import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))" | xargs -n1 pip install --upgrade
    else
        echo -e "${RED}[!]${NOCOLOR} Not updating pip..."
    fi
}

function brewup() {
    if grep -q 1 ~/.zmisc/brew.dat; then
        brew update -v
        brew upgrade -v
    else
        echo -e "${RED}[!]${NOCOLOR} Not updating homebrew..."
    fi
}

function macup() {
    if grep -q 1 ~/.zmisc/mac.dat; then
        softwareupdate -l
    else
        echo -e "${RED}[!]${NOCOLOR} Not updating macos..."
    fi
}

# Check if updates are running already

if grep -q 1 "$LOCKFILE"; then

    echo -e "${RED}[!]${NOCOLOR} Updates running already, exiting..."

    exit 0
fi

# Check if this file's last modification is older than 30 minutes

if test "`find ~/.zmisc/lastupdated.dat -mmin +30`"; then

    # Lock updates to eliminate simultaneous updates

    echo "1" > $LOCKFILE

    # Check for internet and update

    inet

    brewup

    pipup

    macup

    # Remove the update lock

    echo "0" > $LOCKFILE

	# Touch the file so the next time the script is run the last update is logged

	touch ~/.zmisc/lastupdated.dat
fi
