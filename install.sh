#!/bin/bash

if [[$EUID -ne 0]]; then
	echo "You must be root to install stuff" 1>&2
	exit 100
fi

echo "welcome dearest human"

echo "what is your installation command?"
read pmin

echo "installing zsh"
yes | $pmin zsh
yes | $pmin lm-sensors
