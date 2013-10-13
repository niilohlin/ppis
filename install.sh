#!/bin/bash

# Check if root
if [[ $EUID -ne 0 ]]; then
	echo "You must be root to install stuff" 1>&2
	exit 100
fi

os=$(lsb_release -s -d)
if echo $os | grep -i --quiet 'Debian\|Ubuntu' ;then
    pmin='apt-get install'
    pmup='apt-get update'
elif echo $os | grep -i --quiet 'OpenSuSE\|RedHat\|Fedora'  ;then
    pmin='yum install'
    pmup='yum update'
elif echo $os |grep -i --quiet 'Arch' ;then
    pmin='pacman -Syu'
    pmup='pacman -Syy'
else
    # installation command, e.g. "apt-get install "
    echo -en "\ec"
    echo -n "enter your installation command :> "
    read pmin
    echo -n "enter your update command :> "
    read pmup
fi
username=$(logname)
$(pmup)


#two parralell list containing the avalable programs to install
programs=("vim" "gvim" "rxvt-unicode" "zsh" "git" "synapse" "anki" "flashplugin-nonfree" "preload" "prelink" "build-essential || $(pmin) gcc || $(pmin) make" "keepassx" "gparted" "tmux" "inconsolata" "chromium-browser || $(pmin) chomium" "arandr" "conky")
# true indicates that it will be installed
installs=(true true true true true true true false true true false true true true true true true true)

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
configures=("vim" "urxvt" "zsh" "git" "tmux" "keyboard layout" "conky")
customs=(true true true true true true true)
updates=(true true true true true true true)

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

#prompt for updates

while [ true ]
do
    echo -en "\ec"
    echo "Please enter what you want to automaticallly update"
    echo -e "-1 \t [ ] continue/run"
    for ((i=0; i<${#configures[@]-1}; i++))
    do
        if [[ ${updates[$i]} == true ]];then
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
    if [[ ${updates[$input]} == true ]];then
        updates[$input]=false
    else
        updates[$input]=true
    fi
done


# install the programs

for ((i=0; i<${#programs[@]-1}; i++))
do
	if [[ ${installs[$i]} == true ]];then
		echo -e "\033[1;33minstalling ${programs[$i]}"
        tput sgr0
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
		if [[ ${configures[$i]} == "vim" ]];then
			cp -r ./vimrc /home/$username/.vim/vimrc
		elif [[ ${configures[$i]} == "urxvt" ]];then
			cp ./Xdefaults /home/$username/.Xdefaults
			cp ./Xresources /home/$username/.Xresources
		elif [[ ${configures[$i]} == "zsh" ]];then
			cp ./zshrc /home/$username/.zshrc
		elif [[ ${configures[$i]} == "tmux" ]];then
			cp ./tmux.conf /home/$username/.tmux.conf
		elif [[ ${configures} == "git" ]];then
			git config --global user.name "Niil Öhlin"
			git config --global user.email niil.94@hotmail.com
			git config --global core.editor vim
		elif [[ ${configures[$i]} == "keyboard layout" ]];then
			echo "backing up old keymap symbols"
			cp -r /usr/share/X11/xkb/symbols/us /usr/share/X11/xkb/symbols/us.bak
			echo "copying custom keymap symbols"
			cp -r ./us /usr/share/X11/xkb/symbols/us
        elif [[ ${configures[$i]} == "conky" ]] ;then
            cp ./conkyrc /home/$username/.conkyrc
		fi
	fi
done

echo "remember to change to zsh in /etc/passwd"
echo "remember to set screensetup.sh and synapse on startup"

# and update that shit
for ((i=0; i<${#configures[@]-1}; i++))
do
	# I have no idea of how to do switch case
	if [[ ${updates[$i]} == true ]];then
		echo "configuring ${configures[$i]}"
		if [[ ${configures[$i]} == "vim" ]];then
			cp /home/$username/.vim/vimrc ./vimrc 
		elif [[ ${configures[$i]} == "urxvt" ]];then
			cp /home/$username/.Xdefaults ./Xdefaults 
			cp /home/$username/.Xresources ./Xresources 
        elif [[ ${configures[$i]} == "git" ]];then
            echo
		elif [[ ${configures[$i]} == "zsh" ]];then
			cp /home/$username/.zshrc ./zshrc 
		elif [[ ${configures[$i]} == "tmux" ]];then
			cp /home/$username/.tmux.conf ./tmux.conf 
		elif [[ ${configures[$i]} == "keyboard layout" ]];then
			cp /usr/share/X11/xkb/symbols/us ./us 
        elif [[ ${configures[$i]} == "conky" ]]; then
            cp /home/$username/.conkyrc ./conkyrc
		fi
	fi
done

