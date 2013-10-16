#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "You must be root to install stuff" 1>&2
	exit 100
fi

os=$(lsb_release -s -d)


mkdir temp
cd temp

