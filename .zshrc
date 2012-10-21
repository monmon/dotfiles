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
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data





# path
export PATH=$HOME/local/bin:$HOME/bin:/usr/local/bin:$PATH
if [ -e "$HOME/local32/bin" ]; then
    export PATH=$HOME/local32/bin:$PATH
fi
if [ `uname -m | perl -nle 'm/_64$/ and print 1'` ]; then
    if [ -e "$HOME/local64/bin" ]; then
        export PATH=$HOME/local64/bin:$PATH
    fi
fi

# ls after cd
function chpwd() { ll }

# perlbrew
PERL5_BASHRC="$HOME/perl5/perlbrew/etc/bashrc"
if [ -e $PERL5_BASHRC ]; then 
    source $PERL5_BASHRC
fi

# pythonbrew
PYTHONBREW_BASHRC="$HOME/.pythonbrew/etc/bashrc"
if [ -e $PYTHONBREW_BASHRC ]; then 
    source $PYTHONBREW_BASHRC
fi

# php
export PATH=/usr/local/Cellar/php/5.3.6/bin:$PATH


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

# rbenv
RBENV_HOME="$HOME/.rbenv"
if [ -e $RBENV_HOME ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# pear
PEAR_HOME="$HOME/pear"
if [ -e $PEAR_HOME ]; then
    export PATH="$PEAR_HOME/bin:$PATH"
fi

# phpbrew
PHPBREW_HOME="$HOME/.phpbrew"
if [ -e $PHPBREW_HOME ]; then
    source $PHPBREW_HOME/bashrc
fi

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
#    elif type screen >/dev/null 2>&1; then
    if type screen >/dev/null 2>&1; then
        screen -rx || screen -D -RR
    fi
fi
