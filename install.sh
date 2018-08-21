#!/bin/bash
echo "Setting up your Mac..."
if ! command -v brew &> /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew bundle
for i in $(ls dotfiles); do
    case "$i" in
        "vim-config")
            ln -shfv $(pwd)/dotfiles/"$i" ~/.config/"$i"
            ;;
        *)
            ln -shfv $(pwd)/dotfiles/$i ~/.$i
            ;;
    esac
done
ln -shfv ~/.config/vim-config/init.vimrc ~/.vimrc
