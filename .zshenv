# path
export PATH=$HOME/local/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH
if [ -e "$HOME/local32/bin" ]; then
    export PATH=$HOME/local32/bin:$PATH
fi
if [ `uname -m | perl -nle 'm/_64$/ and print 1'` ]; then
    if [ -e "$HOME/local64/bin" ]; then
        export PATH=$HOME/local64/bin:$PATH
    fi
fi

## Perl
# http://d.hatena.ne.jp/okamuuu/20101227/1293416212
PERL5_BASHRC="$HOME/perl5/perlbrew/etc/bashrc"
if [ -e $PERL5_BASHRC ]; then
    source $PERL5_BASHRC
fi

## pythonbrew
PYTHONBREW_BASHRC="$HOME/.pythonbrew/etc/bashrc"
if [ -e $PYTHONBREW_BASHRC ]; then
    source $PYTHONBREW_BASHRC
fi

## php
export PATH=/usr/local/Cellar/php/5.3.6/bin:$PATH

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
