# http://blog.n-z.jp/blog/2013-12-12-zsh-cleanup-path.html
typeset -U path PATH

# path
export PATH=$HOME/local/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:$PATH
if [ -e "$HOME/local32/bin" ]; then
    export PATH=$HOME/local32/bin:$PATH
fi
if [ `uname -m | perl -nle 'm/_64$/ and print 1'` ]; then
    if [ -e "$HOME/local64/bin" ]; then
        export PATH=$HOME/local64/bin:$PATH
    fi
fi

# pear
PEAR_HOME="$HOME/pear"
if [ -e $PEAR_HOME ]; then
    export PATH="$PEAR_HOME/bin:$PATH"
fi

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
