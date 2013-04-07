export LANG=ja_JP.UTF-8

### alias
case "${OSTYPE}" in
    darwin*)
        alias ls='ls -G -w'
        alias ll='ls -lrtF'
        ;;
    linux*)
        alias ls='ls --color'
        alias ll='ls -lrtF'
        ;;
esac

# standard
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias t='tmux'      # tmux


# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

zshaddhistory(){
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    [[ ${#line} -ge 5
        && ${cmd} != (l|l[sal])
        && ${cmd} != (cd)
        && ${cmd} != (man)
        && ${cmd} != (rm)
        && ${cmd} != (fg)
    ]]
}

# ls after cd
function chpwd() { ll }

## complement
autoload -U compinit
compinit

## for git
# 
# VCS settings
autoload -Uz vcs_info
precmd(){
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
}
case "${OSTYPE}" in
    darwin*)
        #PROMPT=$'%2F%n@%m%f %3F%~%f%1v\n%# '
        PROMPT="%1(v|%F{green}%1v%f|)[%T]%% "
        ;;
    linux*)
        case "${HOSTNAME}" in
            *dev*)
                PROMPT="%1(v|%F{green}%1v%f|)[%T@%F{white}%m%f]%% "
                ;;
            *)
                PROMPT="%1(v|%F{green}%1v%f|)%F{red}[%T@%m]%%%f "
                ;;
        esac
        ;;
esac
RPROMPT="[%~]"

# tmux + screen
if [ -z "$TMUX" -a -z "$STY" ]; then
#    if type tmuxx >/dev/null 2>&1; then
#        tmuxx
#    elif type tmux >/dev/null 2>&1; then
#        if tmux has-session && tmux list-sessions | grep -qE '.*]$'; then
#            tmux attach && echo "tmux attached session "
#        else
#            tmux new-session && echo "tmux created new session"
#        fi
    if [ -z "$SSH_CONNECTION" ]; then
        :;
    elif type screen >/dev/null 2>&1; then
        screen -rx || screen -D -RR
    fi
fi

case "$TERM" in
screen)
    preexec() {
        echo -ne "\ek#${1%% *}\e\\"
    }
    precmd() {
        echo -ne "\ek$(basename $(pwd))\e\\"
    }
esac
