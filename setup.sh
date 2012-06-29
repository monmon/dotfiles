#!/bin/bash

for file in `find $HOME/dotfiles -maxdepth 1 -name '.*' | grep -v 'dotfiles/.git$' | perl -nle 'm!dotfiles/(.+)$! and print $1'`; do
    if [ -e $HOME/$file ]; then
        echo "exists $HOME/$file"
    else
        ln -s $HOME/dotfiles/$file $HOME/$file
    fi
done
