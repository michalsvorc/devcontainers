#!/usr/bin/env bash
#
# Installs Rust programming language.
# Dependencies: curl
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
# Functions
#===============================================================================

main() {
  install
}

install() {
  local -r SOURCE_URL='https://sh.rustup.rs'
  curl \
    --proto '=https' \
    --tlsv1.2 \
    -sSf \
    "${SOURCE_URL}" |
    sh -s -- -y
}

#===============================================================================
# Execution
#===============================================================================

main
