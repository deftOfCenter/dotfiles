#!/bin/bash
# Install .dotfiles

# -- Import from other scripts -------------------------------------------------

source 'scripts/helpers/colors.sh'
source 'scripts/helpers/functions.sh'

# -- OSX- or Linux-Specific Setup ----------------------------------------------

if system_is_OSX; then

  source 'scripts/osx.sh'

elif system_is_linux; then

  source 'scripts/ubuntu.sh'

fi

# -- GIT -----------------------------------------------------------------------

if get_boolean_response "Do you want to install the Git configuration files?"
then
  ln -sf $HOME/.dotfiles/git/gitignore_global $HOME/.gitignore_global
  echo_item "Linked global .gitignore" "green"

  ln -sf $HOME/.dotfiles/git/gitconfig $HOME/.gitconfig
  echo_item "Linked gitconfig" "green"
else
  echo_item "Ignoring Git configuration" red
fi

echo ""

# -- ZSH Setup -----------------------------------------------------------------

if exists "zsh"; then
  if get_boolean_response "Do you want to install ZSH configuration files?"; then

    # -- ZSHRC
    ln -sf $HOME/.dotfiles/zsh/zshrc $HOME/.zshrc
    echo_item "Linked zshrc" "green"

    # -- OH MY ZSH
    if [ -d $HOME/.oh-my-zsh/ ]; then
      echo_item "Oh my ZSH is already installed" "green"
    else
      if exists "curl"; then
        curl -L http://install.ohmyz.sh | sh
      elif exists "wget"; then
        wget --no-check-certificate http://install.ohmyz.sh -O - | sh
      else
        echo_item "You need either curl or wget installed to download Oh My ZSH"
      fi
    fi

  else
    echo_item "Ignoring ZSH configuration" "red"
  fi
else
  echo_item "ZSH is not installed"
fi

echo ""

# -- TMUX ----------------------------------------------------------------------

if get_boolean_response "Do you want to install the Tmux configuration file?"
then
  ln -sf $HOME/.dotfiles/tmux/tmux.conf $HOME/.tmux.conf
  echo_item "Linked tmux configutation" "green"
else
  echo_item "Ignoring Tmux configuration" "red"
fi

echo ""

# -- NEOVIM --------------------------------------------------------------------
# Link the dotfiles

# TODO: Ask if the user wants to copy the current configuration to a .local file
if get_boolean_response "Do you want to install the Neovim configuration file?"
then
  ln -sf $HOME/.dotfiles/nvim/init.vim $HOME/.config/nvim/init.vim
  echo_item "Linked Neovim configuration" "green"
else
  echo_item "Ignoring Neovim configuration" red
fi

echo ""

