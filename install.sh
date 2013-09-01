#!/bin/bash

if [[$EUID -ne 0]]; then
	echo "You must be root to install stuff" 1>&2
	exit 100
fi

echo "welcome dearest human"

echo "what is your installation command?"
read pmin
each "what is your username?"
read username

function do_you() {
	read -p "do you want to install $1" -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		yes | $pmin $1
	fi
}

echo "installing and configuring vim"
yes | $pmin vim
cp -r ./vim /home/$username/.vim
echo "installing and configuring urxvt"
yes | $pmin rxvt-unicode
cp ./Xdefaults /home/$username/.Xdefaults
cp ./Xresources /home/$username/.Xresources
echo "installing and configuring zsh"
yes | $pmin zsh
cp ./zshrc /home/$username/.zshrc
echo "installing and configuring tmux"
yes | $pmin tmux
cp ./tmux.conf /home/$username/.tmux.conf
echo "installing and configuring git"
yes | $pmin git
git config --global user.name "Niil Öhlin"
git config --global user.email niil.94@hotmail.com
git config --global core.editor vim
echo "installing synapse"
yes | $pmin synapse
echo "backing up old keymap symbols"
cp -r /usr/share/X11/xkb/symbols /usr/share/X11/xkb/symbols.bak
echo "copying custom keymap symbols"
cp -r ./symbols /usr/share/X11/xkb/symbols



echo "suggested programs:"
echo "flashplugin-nonfree"
echo "anki"
echo "preload prelink"
echo "build-essential"
echo "gparted"
echo "chromium"
echo "keepassx"
echo "unetbootin"


echo "remember to change to zsh in /etc/passwd"
echo "remember to set screensetup.sh and synapse on startup"
