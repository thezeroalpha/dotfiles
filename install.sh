#!/bin/bash

for i in *; do
    case "$i" in
        "vim-config")
            echo "ln -shf $(pwd)\"$i\" ~/.config/\"$i\""
            ln -shf $(pwd)/"$i" ~/.config/"$i"
            ;;
        "exclude")
            ;;
        *)
            echo "ln -shf $(pwd)/$i ~/.$i"
            ln -shf $(pwd)/$i ~/.$i
            ;;
    esac
done
ln -shf ~/.config/vim-config/init.vimrc ~/.vimrc
