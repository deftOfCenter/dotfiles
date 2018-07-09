#!/bin/bash
# OSX.sh

# -- Homebrew ------------------------------------------------------------------

if exists "brew"; then
  echo_item "Homebrew is already installed" green
else
  if get_boolean_response "Do you want to install Homebrew?"; then
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  else
    echo_item "Skipping Homebrew install" "red"
  fi
fi

echo ""

# -- asdf ---------------------------------------------------------------------

if exists "asdf"; then
  echo_item "asdf is already installed" "green"
else
  if get_boolean_response "Do you want to install asdf?"; then
    brew install coreutils automake autoconf openssl libyaml readline libxslt libtool unixodbc gpg
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.5.0
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
    echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
    . $HOME/.asdf/asdf.sh
    . $HOME/.asdf/completions/asdf.bash
    if get_boolean_response "Do you want to install asdf-nodejs?"; then
      # Node.js
      ln -sf $HOME/.dotfiles/asdf/default-npm-packages $HOME/.default-npm-packages
      asdf plugin-add nodejs
      bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
      asdf install nodejs 10.6.0
      # yarn
      brew install yarn --without-node
    else
      # -- nvim ----------------------------------------------------------------------

      if exists "nvm"; then
        echo_item "nvm is already installed" "green"
      else
        if get_boolean_response "Do you want to install nvm?"; then
          touch ~/.bash_profile
          wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
          export NVM_DIR="$HOME/.nvm"
          [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
          nvm install node
        else
          echo_item "Skipping nvm install" "red"
        fi
      fi

      echo ""
    fi
    if get_boolean_response "Do you want to install asdf-ruby?"; then
      # Ruby
      ln -sf $HOME/.dotfiles/asdf/default-gems $HOME/.default-gems
      asdf plugin-add ruby
      asdf install ruby 2.5.1
      asdf global ruby 2.5.1
    else
      # -- rbenv ---------------------------------------------------------------------

      if exists "rbenv"; then
        echo_item "rbenv is already installed" "green"
      else
        if get_boolean_response "Do you want to install rbenv?"; then
          brew install rbenv ruby-install
          rbenv rehash
        else
          echo_item "Skipping rbenv install" "red"
        fi
      fi

      echo ""

    fi
  else
    echo_item "Skipping asdf install" "red"

    # -- rbenv ---------------------------------------------------------------------

    if exists "rbenv"; then
      echo_item "rbenv is already installed" "green"
    else
      if get_boolean_response "Do you want to install rbenv?"; then
        brew install rbenv ruby-install
        rbenv rehash
      else
        echo_item "Skipping rbenv install" "red"
      fi
    fi

    echo ""

    # -- nvim ----------------------------------------------------------------------

    if exists "nvm"; then
      echo_item "nvm is already installed" "green"
    else
      if get_boolean_response "Do you want to install nvm?"; then
        touch ~/.bash_profile
        wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
        nvm install node
      else
        echo_item "Skipping nvm install" "red"
      fi
    fi

    echo ""
  fi

fi

echo ""

# -- zsh -----------------------------------------------------------------------

if exists "zsh"; then
  echo_item "zsh is already installed" green
else
  if get_boolean_response "Do you want to install zsh?"; then
    brew install zsh
    brew install fortune
  else
    echo_item "Skipping zsh install" red
  fi
fi

echo ""

# -- Neovim --------------------------------------------------------------------

if exists "nvim"; then
  echo_item "Neovim is already installed" green
else
  if get_boolean_response "Do you want to install Neovim?"; then
    brew install --HEAD neovim
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    pip2 install --user neovim
    pip3 install --user neovim
  else
    echo_item "Skipping Neovim install" red
  fi
fi
