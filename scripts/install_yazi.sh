#!/usr/bin/env bash
#
# Installs yazi binary.
# https://github.com/sxyazi/yazi
# https://yazi-rs.github.io/docs/installation/
# Dependencies: cargo
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

readonly REPOSITORY='sxyazi/yazi.git'

#===============================================================================
# Arguments
#===============================================================================

#===============================================================================
# Functions
#===============================================================================

main() {
  printf "Installing %s\n" "${REPOSITORY}"
  install
}

install() {
  local -r package='yazi-fm'
  source "${HOME}/.cargo/env"
  cargo install \
    --locked \
    --git "https://github.com/${REPOSITORY}" \
    "${package}"
}

#===============================================================================
# Execution
#===============================================================================

main
