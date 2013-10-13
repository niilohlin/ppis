#!/bin/bash

# Check if root
if [[$EUID -ne 0]]; then
	echo "You must be root to install stuff" 1>&2
	exit 100
fi

os=$(lsb_release -s -d)
if echo $os | grep -i --quiet 'Debian\|Ubuntu' ;then
    pmin='apt-get install'
elif echo $os | grep -i --quiet 'OpenSuSE\|RedHat\|Fedora'  ;then
    pmin='yum install'
else
    # installation command, e.g. "apt-get install "
    echo -en "\ec"
    echo -n "enter your installation command :> "
    read pmin
fi
username=$(whoami)

#two parralell list containing the avalable programs to install
programs=("vim" "gvim" "rxvt-unicode" "zsh" "git" "synapse" "anki" "flashplugin-nonfree" "preload" "prelink" "build-essential" "keepassx" "gparted" "tmux" "inconsolata")
# true indicates that it will be installed
installs=(true true true true true true true false true true false true true true true)

while [ true ]
do
	# clear screen
	echo -en "\ec"
	echo "Please enter what you want to install."
	echo -e "-1 \t [ ] continue/run"
	for ((i=0; i<${#programs[@]-1}; i++))
	do
		#print a little asterisk in the box if the prorgam is marked
		# for download
		if [[ ${installs[$i]} == true ]];then
			printf "%s\t %s %s\n" "$i" "[*]" "${programs[$i]}" 
		else
			printf "%s\t %s %s\n" "$i" "[ ]" "${programs[$i]}" 
		fi
	done
	# prompt for installation number
	echo -n "install number :> "
	read input
	if [[ $input -eq -1 ]]; then
		break
	fi
	if [[ ${installs[$input]} == true ]];then
		installs[$input]=false
	else
		installs[$input]=true
	fi
done


# same here, but with preconfigured rc files and .conf files
configures=("vim" "urxvt" "zsh" "git" "tmux" "keyboard layout")
customs=(true true true true true true)

while [ true ]
do
	echo -en "\ec"
	echo "Please enter what you want to automaticallly configure"
	echo -e "-1 \t [ ] continue/run"
	for ((i=0; i<${#configures[@]-1}; i++))
	do
		if [[ ${customs[$i]} == true ]];then
			printf "%s\t %s %s\n" "$i" "[*]" "${configures[$i]}" 
		else
			printf "%s\t %s %s\n" "$i" "[ ]" "${configures[$i]}" 
		fi
	done
	echo -n "configure number :> "
	read input
	if [[ $input -eq -1 ]]; then
		break
	fi
	if [[ ${customs[$input]} == true ]];then
		customs[$input]=false
	else
		customs[$input]=true
	fi
done
exit 0

# install the programs
for ((i=0; i<${#programs[@]-1}; i++))
do
	if [[ ${installs[$i]} == true ]];then
		echo "installing ${programs[$i]}"
		# send expands to
		# yes | apt-get install vim
		# for example
		yes | $pmin ${programs[$i]}
	fi
	echo -en "\ec"
done

# and configure that shit
for ((i=0; i<${#configures[@]-1}; i++))
do
	# I have no idea of how to do switch case
	# and it's not important
	if [[ ${customs[$i]} == true ]];then
		echo "configuring ${configures[$i]}"
		if [[ ${configures[$i]} -eq "vim" ]];then
			cp -r ./vim /home/$username/.vim
		fi
		if [[ ${configures[$i]} -eq "urxvt" ]];then
			cp ./Xdefaults /home/$username/.Xdefaults
			cp ./Xresources /home/$username/.Xresources
		fi
		if [[ ${configures[$i]} -eq "zsh" ]];then
			cp ./zshrc /home/$username/.zshrc
		fi
		if [[ ${configures[$i]} -eq "tmux" ]];then
			cp ./tmux.conf /home/$username/.tmux.conf
		fi
		if [[ ${configures} -eq "git" ]];then
			git config --global user.name "Niil Öhlin"
			git config --global user.email niil.94@hotmail.com
			git config --global core.editor vim
		fi
		if [[ ${configures[$i]} -eq "keyboard layout" ]];then
			echo "backing up old keymap symbols"
			cp -r /usr/share/X11/xkb/symbols /usr/share/X11/xkb/symbols.bak
			echo "copying custom keymap symbols"
			cp -r ./symbols /usr/share/X11/xkb/symbols
		fi
	fi
done

echo "remember to change to zsh in /etc/passwd"
echo "remember to set screensetup.sh and synapse on startup"
