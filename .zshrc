export LANG=ja_JP.UTF-8

# alias
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

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'


PROMPT="[%T]%% "
RPROMPT="[%~]"

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
export PATH=/usr/local/bin:$PATH

# ls after cd
function chpwd() { ll }

# perlbrew
PERL5_BASHRC="~/perl5/perlbrew/etc/bashrc"
if [ -e $PERL5_BASHRC ]; then 
    source $PERL5_BASHRC
fi

# pythonbrew
PYTHONBREW_BASHRC="~/.pythonbrew/etc/bashrc"
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
#PROMPT=$'%2F%n@%m%f %3F%~%f%1v\n%# '
PROMPT="%1(v|%F{green}%1v%f|)[%T]%% "
