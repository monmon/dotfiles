# http://blog.n-z.jp/blog/2013-12-12-zsh-cleanup-path.html
typeset -U path PATH

# http://arq.name/cygmake/cygwin/zshrc.html
ZDOTDIR=$HOME/.zsh
export ZDOTDIR

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
# http://qiita.com/luckypool/items/f1e756e9d3e9786ad9ea
for D in `find $HOME/.anyenv/envs -type d -d 1`
do
    export PATH="$D/shims:$PATH"
done
