# https://qiita.com/sayama0402/items/adc1980b83d16c9a9bb0
# https://sanoto-nittc.hatenablog.com/entry/2017/12/16/213735

# 補完
autoload -Uz compinit && compinit

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt hist_ignore_space    # スペースで始まるコマンド行はヒストリリストから削除
setopt hist_verify          # ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_reduce_blanks   # 余分な空白は詰めて記録
setopt hist_no_store        # historyコマンドは履歴に登録しない
setopt hist_expand          # 補完時にヒストリを自動的に展開d
setopt inc_append_history   # 履歴をインクリメンタルに追加
setopt share_history        # share command history data
setopt EXTENDED_HISTORY

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

source ~/.zsh/zshrc-zplug

autoload -U promptinit; promptinit
# プロンプトを変更
prompt pure

setopt auto_cd
setopt auto_menu

# User configuration

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export PATH=$HOME/bin:$HOME/dotfiles/bin:$HOME/.anyenv/bin::/usr/local/bin:$PATH
eval "$(anyenv init -)"
# http://qiita.com/luckypool/items/f1e756e9d3e9786ad9ea
for D in `find $HOME/.anyenv/envs -type d -d 1`
do
    export PATH="$D/shims:$PATH"
done

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=ja_JP.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
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
alias ssh=~/bin/ssh-host-color
