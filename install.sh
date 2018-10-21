#!/bin/bash
if [ $(pwd) != "$HOME/.dotfiles" ]; then
    echo "Please clone this directory as $HOME/.dotfiles."
    exit 1
fi

if [[ $(uname -s) == "Darwin" ]]; then
    echo "Setting up your Mac..."
    if ! command -v brew &> /dev/null; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    if [ -f "Brewfile" ]; then
	brew bundle
    fi
elif [[ $(uname -s) == "Linux" ]]; then
    echo "Setting up your Linux environment..."
else
    echo "Does not work on this OS, sorry."
    exit 1
fi


lncommand() { ln -snfv $(pwd)/"$1" "$2"; }

if [ -d ".bin" ]; then
    lncommand "bin" "$HOME/.bin"
fi

if [ -d "oh-my-zsh" ]; then
    lncommand "oh-my-zsh" "$HOME/.oh-my-zsh"
fi

if [ -f "other-scripts/gdbinit" ]; then
    lncommand "other-scripts/gdbinit" "$HOME/.gdbinit"
fi

if [ -d "shell" ]; then
    for i in $(ls shell); do
	lncommand shell/"$i" $HOME/."$i"
    done
fi

if [ -d "git" ]; then
    for i in $(ls git); do
	lncommand git/"$i" $HOME/."$i"
    done
fi

if [ -f "other-scripts/radio-config" ]; then
    lncommand "other-scripts/radio-config" "$HOME/.radio-config"
fi

if [ -d "vim" ]; then
    lncommand vim/init.vimrc $HOME/.vimrc
    lncommand vim/idea.vimrc $HOME/.ideavimrc
fi

unset -f lncommand
export CONFDIR="$HOME/.dotfiles"
