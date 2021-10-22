#! /bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew bundle -f Brewfile.common
if [ "$(uname -s)" = "Darwin" ]
then
  brew bundle -f Brewfile.ios
fi
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash

