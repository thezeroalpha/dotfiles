#!/bin/bash
for i in *; do
    case "$i" in
        "vim-config")
            echo "ln -sf $(pwd)\"$i\" ~/.config/\"$i\""
            ln -sf $(pwd)/"$i" ~/.config/"$i"
            ;;
        *)
            echo "ln -sf $(pwd)/$i ~/.$i"
            ln -sf $(pwd)/$i ~/.$i
            ;;
    esac
done
ln -sf ~/.config/vim-config/init.vimrc ~/.vimrc
