# macscripts

Scripts to enhance MacOS. It checks for MacOS updates (updater.sh),optionally autoupdates homebrew and also provides easy to remember aliases to check for updates and upgrade MacOS. Optionally adds symlinks from iCloud storage to local storage for ease of use. 

## Dependencies

Stock MacOS (version >=10.15) includes the required dependencies which are zsh and bash. 

## Install

First, there are a few options you should consider.

#### 1. Backing up .ssh, .gnupg, and .config to iCloud

If you want this option, then do `touch ICLOUD.dat` in the git repo. It will automatically back up those directories to iCloud. 

#### 2. Adding homebrew support

If you want to automatically update homebrew, then do `touch BREW.dat` in the git repo. It will make it so the script automatically updates homebrew.

After configurating, run `install.sh` from the git directory.

## Devs

Pull requests welcom. Bash is used only just cause I'm more familiar with it than zsh. Plus syntax won't change at all since bash is frozen in MacOS due to licensing issues.
