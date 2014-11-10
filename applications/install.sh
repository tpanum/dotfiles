if test ! $(which brew)
then
    echo "  Unable to find Homebrew. Can't install applications."
    exit 1
fi


# Setup cask
brew tap caskroom/cask
brew install brew-cask

# Emacs
brew tap railwaycat/emacsmacport
brew install emacs-mac

# Node
brew install nvm
nvm install stable

# Meteor
curl https://install.meteor.com/ | sh

# Go
brew install go

# .app Applications

brew tap caskroom/cask
brew install brew-cask

brew cask install google-chrome
brew cask install dropbox
brew cask install mactex
