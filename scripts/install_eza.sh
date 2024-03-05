#!/usr/bin/env bash
#
# Installs eza binary.
# https://github.com/eza-community/eza
# https://github.com/eza-community/eza/blob/main/INSTALL.md
# Dependencies: curl, tar, cargo
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

readonly REPOSITORY='eza-community/eza'

tag="${1:-}"
readonly target_path="${2:-/tmp}"

#===============================================================================
# Functions
#===============================================================================

function main() {
  printf "Installing %s %s\n" "${REPOSITORY}" "${tag:-latest}"
  install
}

function get_latest_tag() {
  local -r url="https://api.github.com/repos/${REPOSITORY}/releases/latest"
  curl -s "${url}" | jq -r .tag_name
}

function download() {
  local -r url="https://github.com/${REPOSITORY}/archive/refs/tags/${tag}.tar.gz"
  curl -L "${url}" |
    tar -xz -C "${target_path}"
}

function install() {
  local -r name="${REPOSITORY#*/}"
  local crate="${name}"
  if [[ -n "${tag}" ]]; then
    crate="${name}@${tag}"
  fi
  source "${HOME}/.cargo/env"
  cargo install "${crate}"
}

#===============================================================================
# Execution
#===============================================================================

main
