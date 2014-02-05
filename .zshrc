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
setopt hist_ignore_space    # スペースで始まるコマンド行はヒストリリストから削除
setopt hist_verify          # ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_reduce_blanks   # 余分な空白は詰めて記録
setopt hist_no_store        # historyコマンドは履歴に登録しない
setopt hist_expand          # 補完時にヒストリを自動的に展開d
setopt inc_append_history   # 履歴をインクリメンタルに追加
setopt share_history        # share command history data
setopt EXTENDED_HISTORY

# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

function history-all { history -E 1 }

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
        PROMPT=$'\n'"[%T] %3F%~%f"$'\n'"%1(v|%F{green}%1v%f|)%% "
        RPROMPT=
        ;;
    linux*)
        case "${HOSTNAME}" in
            *dev*)
                PROMPT="%1(v|%F{green}%1v%f|)[%T@%F{white}%m%f]%% "
                PROMPT=$'\n'"[%T@%F{white}%m%f] %3F%~%f"$'\n'"%1(v|%F{green}%1v%f|)%% "
                ;;
            *)
                PROMPT="%1(v|%F{green}%1v%f|)%F{red}[%T@%m]%%%f "
                PROMPT=$'\n'"%F{red}[%T@%m]%f %3F%~%f"$'\n'"%1(v|%F{green}%1v%f|)%% "
                ;;
        esac
        RPROMPT=
        ;;
esac

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
fpath=(/usr/local/share/zsh-completions $fpath)

export EDITOR="vim"
export GOPATH=$HOME/gocode

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
