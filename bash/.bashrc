#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll="ls -lhA --color=auto"
alias lsl="ls -lhFA --color | less -R"

alias cd..='cd ..' 
alias ..='cd ..' 

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

alias myip="curl http://ipecho.net/plain; echo"
#alias myip6="curl http://v6.ifconfig.co"
alias myip6="curl v6.ident.me"

alias spm="sudo pacman"
alias top="htop"

alias vim="nvim"
alias vi="nvim"

PS1='[\u@\h \W]\$ '

export EDITOR=nvim
#alias rgmp3='/home/ludwig/shellscripts/replaygain/mp3/rgmp3.sh'
#export LIBVA_DRIVER_NAME=vdpau
#export VDPAU_DRIVER=r600
eval "$(thefuck --alias)"
export TERM=xterm-256color

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}
