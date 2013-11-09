#!/bin/zsh

xhost +local:root > /dev/null 2>&1

echo "welcome dearest human"

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export SAVEHIST=${HISTSIZE}
export HISTFILE="~/.zsh_hist"

setopt hist_ignore_all_dups
setopt hist_ignore_space

export HD='/run/media/niil/8d25eb81-c066-48cd-a263-83d2b0b3308c/'


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
alias lynx='lynx --accept_all_cookies'
alias no='ls'


set -o vi
set keymap vi-insert
# bind -m vi-instert "\C-l":clear-screen

# prompt
autoload -U colors && colors
PS1="%{%F{red}%}%n%{%f%}@%{%F{blue}%}%m %{%F{yellow}%}%~ %{$%f%}%"


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/bin/
[[ -z "$TMUX" ]] && exec tmux
