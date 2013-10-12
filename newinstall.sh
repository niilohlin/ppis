#!/bin/bash

#if [[$EUID -ne 0]]; then
#	echo "You must be root to install stuff" 1>&2
#	exit 100
#fi


#echo "what is your installation command?"
#read pmin
#echo "what is your username?"
#read username

echo "please enter what you want to install: "

programs=("vim" "gvim" "urxvt" "zsh" "git" "synapse" "anki" "flashplugin-nonfree" "preload" "prelink" "build-essential" "keepassx" "gparted" "tmux")
installs=(true true true true true true true false true true false true true true)

for ((i=0; i<${#programs[@]-1}; i++))
do
	if [[ ${installs[$i]} == true ]];then
		printf "%s\t %s %s\n" "$i" "[*]" "${programs[$i]}" 
	else
		printf "%s\t %s %s\n" "$i" "[ ]" "${programs[$i]}" 
	fi
done

#echo "installing and configuring vim"
#yes | $pmin vim
#cp -r ./vim /home/$username/.vim
#echo "installing and configuring urxvt"
#yes | $pmin rxvt-unicode
#cp ./Xdefaults /home/$username/.Xdefaults
#cp ./Xresources /home/$username/.Xresources
#echo "installing and configuring zsh"
#yes | $pmin zsh
#cp ./zshrc /home/$username/.zshrc
#echo "installing and configuring tmux"
#yes | $pmin tmux
#cp ./tmux.conf /home/$username/.tmux.conf
#echo "installing and configuring git"
#yes | $pmin git
#git config --global user.name "Niil Öhlin"
#git config --global user.email niil.94@hotmail.com
#git config --global core.editor vim
#echo "installing synapse"
#yes | $pmin synapse
#echo "backing up old keymap symbols"
#cp -r /usr/share/X11/xkb/symbols /usr/share/X11/xkb/symbols.bak
#echo "copying custom keymap symbols"
#cp -r ./symbols /usr/share/X11/xkb/symbols
#
#
#
#echo "suggested programs:"
#echo "flashplugin-nonfree"
#echo "anki"
#echo "preload prelink"
#echo "build-essential"
#echo "gparted"
#echo "chromium"
#echo "keepassx"
#echo "unetbootin"
#
#
#echo "remember to change to zsh in /etc/passwd"
#echo "remember to set screensetup.sh and synapse on startup"
