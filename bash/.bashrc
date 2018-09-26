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
alias myip6="curl v6.ident.me"

alias spm="sudo pacman"
alias top="htop"

alias vi="vim"

# source ~/.bash-powerline.sh

# PS1='[\u@\h \W]\$ '

if [ $(id -u) -eq 0 ];
then # you are root, make the prompt red
    PS1='\[\033[1;32m\](\[\033[1;32m\]\u\[\033[1;31m\]@\h\[\033[1;31m\]:\[\033[1;36m\]\w\[\033[1;32m\])\[\033[1;36m\]\$ \[\033[0;37m\]'
else
    PS1='\[\e[1;37m\]\u@\h\[\e[m\] \[\e[0;37m\]\w\[\e[m\] \[\e[1;31m\]$(__git_ps1 "(%s)")\[\e[m\] \[\e[1;37m\]\$ \[\e[m\]\[\e[1;37m\] '
fi

export EDITOR=vim
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

# source ~/.git-completion.bash
# source ~/.git-prompt.sh 

#fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": vim $(fzf);'


sf() {
  if [ "$#" -lt 1 ]; then echo "Supply string to search for!"; return 1; fi
  printf -v search "%q" "$*"
  include="ts,yml,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst"
  exclude=".config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist"
  rg_command='rg --column --line-number --no-heading --no-messages --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{'$include'}" -g "!{'$exclude'}/*"'
  files=`eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}'`
  [[ -n "$files" ]] && ${EDITOR:-vim} $files
}
