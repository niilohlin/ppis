#!/usr/bin/env bash



# same here, but with preconfigured rc files and .conf files
configures=("vim" "urxvt" "zsh" "tmux" "keyboard layout")
customs=(true true true true true)
username=$(whoami)

while [ true ]
do
	echo -en "\ec"
	echo "Please enter what you want to automaticallly update"
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

# and update that shit
for ((i=0; i<${#configures[@]-1}; i++))
do
	# I have no idea of how to do switch case
	# and it's not important
	if [[ ${customs[$i]} == true ]];then
		echo "configuring ${configures[$i]}"
		if [[ ${configures[$i]} -eq "vim" ]];then
			cp /home/$username/.vim/vimrc ./vimrc 
		fi
		if [[ ${configures[$i]} -eq "urxvt" ]];then
			cp /home/$username/.Xdefaults ./Xdefaults 
			cp /home/$username/.Xresources ./Xresources 
		fi
		if [[ ${configures[$i]} -eq "zsh" ]];then
			cp /home/$username/.zshrc ./zshrc 
		fi
		if [[ ${configures[$i]} -eq "tmux" ]];then
			cp /home/$username/.tmux.conf ./tmux.conf 
		fi
		if [[ ${configures[$i]} -eq "keyboard layout" ]];then
			cp /usr/share/X11/xkb/symbols/us ./us 
		fi
	fi
done

