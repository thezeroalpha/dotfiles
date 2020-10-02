#!/usr/bin/env bash
# vim: foldmethod=marker:foldlevel=0

# Preliminary checks {{{
# Check if this directory was cloned properly
if [ "$(pwd)" != "$HOME/.dotfiles" ]; then
  echo "Please clone this directory as $HOME/.dotfiles."
  exit 1
fi

cd "$(dirname "$0")" || { echo "Could not cd into $(dirname "$0")"; exit 1; }

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

export DOTFILES="$HOME/.dotfiles"

read -rn 1 -p "Install all dotfiles? [Y/n]" yn
echo
case $yn in
  [Yy]* )
    yes | scripts/conf link
    echo "Dotfiles installed."
    echo "Run \`conf -h\` for more help."
    ;;
  * )
    echo "No dotfiles installed automatically."
    echo "Run \`scripts/conf -h\` for more help."
    echo "You can also add conf to your path: export PATH=$DOTFILES/scripts:$PATH"
    ;;
esac

echo "Don't forget to create a $DOTFILES/shell/secret_env with:"
# Don't want these variables to expand
# shellcheck disable=SC2016
echo '- $DISCOGS_API_TOKEN'
# shellcheck disable=SC2016
echo '- $HOMEBREW_GITHUB_API_TOKEN'
