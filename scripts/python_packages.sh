#!/usr/bin/env bash
#
# Installs Debian packages for Python environment.
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
  python3-pip
  python3-venv
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
    "${packages[@]}" &&
    rm -rf /var/lib/apt/lists/*
}

main() {
  update
  install
}

#===============================================================================
# Execution
#===============================================================================

main
