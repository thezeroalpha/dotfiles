#!/bin/bash
# vim: foldmethod=marker:foldlevel=0

# Preliminary checks {{{
# Check if this directory was cloned properly
if [ $(pwd) != "$HOME/.dotfiles" ]; then
    echo "Please clone this directory as $HOME/.dotfiles."
    exit 1
fi

if ! [ -f "./install.sh" ]; then
    echo "Please cd into $HOME/.dotfiles before running the script."
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

#}}}

export CONF_DIR="$HOME/.dotfiles"
bin/conf stow $(find . ! -iwholename '*.git*' -type d -d 1)

echo "Dotfiles installed."
bin/conf reload
echo "Run `conf` for more help."

echo "Don't forget to create a ~/.secret_env_variables with:"
echo '- $DISCOGS_API_TOKEN'
echo '- $HOMEBREW_GITHUB_API_TOKEN'
