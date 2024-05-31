#!/usr/bin/env bash
#
# Installs Debian packages for base environment runner stage.
# Dependencies: apt-get
#
# Author: Michal Svorc <dev@michalsvorc.com>
# License: MIT license (https://opensource.org/licenses/MIT)
# Guidelines: https://google.github.io/styleguide/shell

#===============================================================================
# Abort the script on errors and unbound variables
#===============================================================================

set -o errexit  # Exit if any command exits with a nonzero (error) status.
set -o nounset  # Disallow expansion of unset variables.
set -o pipefail # Use last non-zero exit code in a pipeline.
set -o errtrace # Ensure the error trap handler is properly inherited.
# set -o xtrace   # Enable shell script debugging mode.

#===============================================================================
# Variables
#===============================================================================

packages=(
  ca-certificates
  bat
  curl
  fd-find
  file
  fzf
  g++
  git
  gpg
  htop
  jq
  less
  locales
  lsb-release
  nodejs
  npm
  make
  openssh-client
  p7zip
  procps
  ripgrep
  rsync
  shellcheck
  tmux
  unzip
  zsh
)

#===============================================================================
# Functions
#===============================================================================

main() {
  update
  install
}

update() {
  apt-get update
}

install() {
  DEBIAN_FRONTEND=noninteractive \
    apt-get install \
    --assume-yes \
    --no-install-recommends \
    --quiet \
    "${packages[@]}" &&
    rm -rf /var/lib/apt/lists/*
}

#===============================================================================
# Execution
#===============================================================================

main
