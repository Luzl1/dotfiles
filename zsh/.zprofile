#if [[ -z $(pidof ssh-agent) && -z $(pidof gpg-agent) ]]; then
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

export GPG_TTY=$(tty)
export GPG_AGENT_INFO=""
export EDITOR="/usr/bin/vim"
