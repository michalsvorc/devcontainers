#!/usr/bin/env bash
#
# Installs Neovim binary.
# https://github.com/neovim/neovim
# Dependencies: curl, tar, make
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

readonly REPOSITORY='neovim/neovim'

#===============================================================================
# Arguments
#===============================================================================

readonly tag="${1:-nightly}"
readonly target_path="${2:-/tmp}"

#===============================================================================
# Functions
#===============================================================================

main() {
  printf "Installing %s %s\n" "${REPOSITORY}" "${tag}"
  download &&
    cd "$(get_asset_dir)" &&
    install
}

download() {
  local -r url="https://github.com/${REPOSITORY}/archive/refs/tags/${tag}.tar.gz"
  curl -L "${url}" |
    tar -xz -C "${target_path}"
}

get_asset_dir() {
  local -r name="${REPOSITORY#*/}"
  local -r download_dir="${target_path}/${name}-${tag}"
  printf "%s" "${download_dir}"
}

install() {
  make CMAKE_BUILD_TYPE=Release
  make install
}

#===============================================================================
# Execution
#===============================================================================

main
