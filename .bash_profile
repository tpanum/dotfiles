export GOPATH="/home/tpanum/go"
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export HISTSIZE=3500

# speed up bash reverse search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

alias mountaau='gpg2 --quiet --batch -d  .aau-passwd.gpg | sshfs -oGSSAPIAuthentication=no -oCheckHostIP=no -o password_stdin "tkp@es.aau.dk"@sfs01.aau.dk:/es/Fileshares/Networksecuritygroup ~/aau_netsec'
alias wifi-list='nmcli dev wifi rescan && nmcli dev wifi list'
export PS1="\n\[\033[1;32m\]\u (\[\033[0m\]\[\e[34m\]\w\[\e[m\]\[\033[1;32m\])\[\033[0m\] $ "

function wifi-connect () {
         nmcli dev wifi connect "$1" password "$2"
}

function whoseport () {
    lsof -i ":$1" | grep LISTEN
}

alias analysis-start='docker run -it -p 8888:8888 -p 6006:6006 -v $(pwd):/work tpanum/analysis-box'
alias open='xdg-open'
alias shutdown='wmctrl -c "firefox" && sleep 0.5 && /run/current-system/sw/bin/shutdown'
alias reboot='wmctrl -c "firefox" && sleep 0.5 && /run/current-system/sw/bin/reboot'
alias fixshebangs="find . -type f -print0 | xargs -0 sed -i 's=#!/bin=#!/run/current-system/sw/bin=g'"
alias killcontainers="docker rm -f $(docker ps -a -q)"
