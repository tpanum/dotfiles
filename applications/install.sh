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
brew install emacs-mac --icon-modern
brew install aspell --lang=en

# Node
brew install nvm
nvm install stable

# Meteor
curl https://install.meteor.com/ | sh

# Go
brew install go

# Ack
brew install ack

# .app Applications
brew cask install alfred
brew cask alfred link

brew cask install google-chrome
brew cask install dropbox
brew cask install mactex
brew cask install skype
