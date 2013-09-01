#!/bin/zsh
# if [ -f /etc/bash_completion ]; then
# 	    . /etc/bash_completion
# fi

xhost +local:root > /dev/null 2>&1

# complete -cf sudo

# shopt -s cdspell
# shopt -s checkwinsize
# shopt -s cmdhist
# shopt -s dotglob
# shopt -s expand_aliases
# shopt -s extglob
# setopt histappend
# shopt -s hostcomplete
# shopt -s nocaseglob

echo "welcome dearest human"

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export SAVEHIST=${HISTSIZE}

setopt hist_ignore_all_dups
setopt hist_ignore_space


alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function mycd {
	cd $1;
	ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F;
}

function clock {
	tty-clock -bcC 4
}

alias cd='mycd'


set -o vi
set keymap vi-insert
# bind -m vi-instert "\C-l":clear-screen

# prompt
PS1='[%n@%M]%~ %# '
BROWSER=/usr/bin/xdg-open

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -z "$TMUX" ]] && exec tmux
