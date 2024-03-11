#!/usr/bin/env bash
#
# Installs Debian packages for base environment builder stage.
# Dependencies: apt-get, curl, sh
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
  build-essential
  ca-certificates
  cmake
  curl
  g++
  gettext
  git
  golang
  gpg
  jq
  libtool-bin
  make
  ninja-build
  pkg-config
  unzip
)

#===============================================================================
# Functions
#===============================================================================

update() {
  apt-get update
}

install() {
  DEBIAN_FRONTEND=noninteractive \
    apt-get install \
    --assume-yes \
    --no-install-recommends \
    --quiet \
    "${packages[@]}"
}

install_rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
}

main() {
  update
  install
  install_rust

}

#===============================================================================
# Execution
#===============================================================================

main
