#!/bin/bash

# Check if this directory was cloned properly
if [ $(pwd) != "$HOME/.dotfiles" ]; then
    echo "Please clone this directory as $HOME/.dotfiles."
    exit 1
fi

# Check if the OS is supported
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
    echo "This OS isn't supported yet."
    exit 1
fi


lncommand() { ln -snfv $(pwd)/"$1" "$2"; }

# Back up previous files
if [ -d "$HOME/.vim" ]; then
    mv "$HOME/.vim" "$HOME/.vim.orig"
fi
if [ -f "$HOME/.vimrc" ]; then
    mv "$HOME/.vimrc" "$HOME/.vimrc.orig"
fi


# Link stuff conditionally in case of a sparse checkout
if [ -d ".bin" ]; then
    lncommand "bin" "$HOME/.bin"
fi

if [ -d "oh-my-zsh" ]; then
    lncommand "oh-my-zsh" "$HOME/.oh-my-zsh"
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

if [ -f "other-scripts/gdbinit" ]; then
    lncommand "other-scripts/gdbinit" "$HOME/.gdbinit"
fi

if [ -f "other-scripts/radio-config" ]; then
    lncommand "other-scripts/radio-config" "$HOME/.radio-config"
fi

if [ -d "vim" ]; then
    # Link vimrc (which points directly to other vim configs)
    lncommand vim/init.vimrc $HOME/.vimrc

    # Link ideavimrc, has to be separate
    lncommand vim/idea.vimrc $HOME/.ideavimrc
fi

export CONFDIR="$HOME/.dotfiles"
