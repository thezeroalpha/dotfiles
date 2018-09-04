#!/bin/bash
echo "Setting up your Mac..."
if ! command -v brew &> /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew bundle

lncommand() { ln -shfv $(pwd)/"$1" "$2"; }

homedir=("bin" "git" "oh-my-zsh" "shell" "other-scripts/gdbinit")
config=("other-scripts/radio-config" "vim-config")

lncommand "bin" "$HOME/.bin"
lncommand "oh-my-zsh" "$HOME/.oh-my-zsh"
lncommand "other-scripts/gdbinit" "$HOME/.gdbinit"

for i in $(ls shell); do
    lncommand shell/"$i" $HOME/."$i"
done

for i in $(ls git); do
    lncommand git/"$i" $HOME/."$i"
done

lncommand "other-scripts/radio-config" "$HOME/.radio-config"

ln -shfv $HOME/.dotfiles/vim/init.vimrc $HOME/.vimrc

unset -f lncommand
