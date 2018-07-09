#!/bin/bash
# ubuntu.sh

# -- Git -----------------------------------------------------------------------

if exists "git"; then
  echo_item "Git is already installed" "green"
else
  sudo apt-get install git
fi

echo ""

# -- zsh -----------------------------------------------------------------------

if exists "zsh"; then
  echo_item "zsh is already installed" green
else
  if get_boolean_response "Do you want to install zsh?"; then
    sudo apt-get install zsh
    sudo apt-get install fortune
  else
    echo_item "Skipping zsh install" red
  fi
fi

echo ""

# -- asdf ---------------------------------------------------------------------

if exists "asdf"; then
  echo_item "asdf is already installed" "green"
else
  if get_boolean_response "Do you want to install asdf?"; then
    sudo apt-get install -y automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev gnupg
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.5.0
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
    echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
    source ~/.zshrc
    if get_boolean_response "Do you want to install asdf-nodejs?"; then
    # Node.js
      ln -sf $HOME/.dotfiles/asdf/default-npm-packages $HOME/.default-npm-packages
      asdf plugin-add nodejs
      bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
      asdf install nodejs 10.6.0
      curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
      sudo apt-get update && sudo apt-get install --no-install-recommends yarn
    else
      # -- nvim ----------------------------------------------------------------------

      if exists "nvm"; then
        echo_item "nvm is already installed" "green"
      else
        if get_boolean_response "Do you want to install nvm?"; then
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
          git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
          git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
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
        git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
        git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
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

# -- htop ----------------------------------------------------------------------

if exists "htop"; then
  echo_item "htop is already installed" green
else
  if get_boolean_response "Do you want to install htop?"; then
    sudo apt-get install htop
  else
    echo_item "Skipping htop install" red
  fi
fi

echo ""

# -- thef**k -------------------------------------------------------------------

sudo pip3 install thefuck
echo -e '\neval $(thefuck --alias damn --enable-experimental-instant-mode)' >> ~/.zshrc

# -- Neovim --------------------------------------------------------------------

if exists "nvim"; then
  echo_item "Neovim is already installed" green
else
  if get_boolean_response "Do you want to install Neovim?"; then
    sudo apt-get --yes --force-yes install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get --yes --force-yes install neovim python-dev python-pip python3-dev python3-pip
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    pip2 install --user neovim
    pip3 install --user neovim
    sudo apt-get install fonts-powerline
  else
    echo_item "Skipping Neovim install" red
  fi
fi

# -- Docker ----------------------------------------------------------------------

if exists "docker"; then
  echo_item "Docker is already installed" green
else
  if get_boolean_response "Do you want to install Docker?"; then
    sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install --yes docker-ce
  else
    echo_item "Skipping Docker install" red
  fi
fi
