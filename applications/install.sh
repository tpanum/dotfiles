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

# Go
brew install go

# rg (replacement for grep)
brew install ripgrep

# .app Applications
brew cask install google-chrome
brew cask install dropbox
brew cask install mactex
