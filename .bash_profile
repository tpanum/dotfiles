export TERM='xterm-256color'
export GOPATH="/home/tpanum/go"
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN:$CONDABIN
export HISTSIZE=3500
export SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"
/run/current-system/sw/bin/gpg-connect-agent updatestartuptty /bye > /dev/null
export PASSWORD_STORE_GENERATED_LENGTH="42"
export GPG_TTY=$(tty)
export FZF_DEFAULT_OPTS='--color pointer:3,info:14,bg+:-1'
export _JAVA_AWT_WM_NONREPARENTING=

# speed up bash reverse search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

alias wifi-list='nmcli dev wifi rescan && nmcli dev wifi list'

PROMPT_DIRTRIM=3
export PS1="\[\033[1;32m\]\u (\[\033[0m\]\[\e[34m\]\W\[\e[m\]\[\033[1;32m\])\[\033[0m\] $ "

function wifi-connect () {
         nmcli dev wifi connect "$1" password "$2"
}

function whoseport () {
    lsof -i ":$1" | grep LISTEN
}

alias shutdown='wmctrl -c "firefox" && sleep 0.5 && /run/current-system/sw/bin/shutdown'
alias reboot='wmctrl -c "firefox" && sleep 0.5 && /run/current-system/sw/bin/reboot'
alias fixshebangs="find . -type f -print0 | xargs -0 sed -i 's=#!/bin=#!/run/current-system/sw/bin=g'"
alias killcontainers="docker rm -f $(docker ps -a -q)"
alias pbcopy="xclip -selection clipboard"
alias hkn="$HOME/.haaukins/hkn-linux-amd64"
alias uwvpn="sudo openconnect dept-ra-cssc.vpn.wisc.edu"
alias emacs="emacsclient -c -a emacs"

for f in /home/tpanum/.exec/*.sh
do
    base=$(basename $f)
    cmd="${base%.*}"
    alias $cmd=$f
done

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/tpanum/.conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/tpanum/.conda/etc/profile.d/conda.sh" ]; then
        . "/home/tpanum/.conda/etc/profile.d/conda.sh"
    else
        export PATH="/home/tpanum/.conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH=~/.npm-packages/bin:$PATH.
export PATH=~/.bin:$PATH.
