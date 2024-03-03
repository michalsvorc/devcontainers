#!/usr/bin/env bash
#
# Install delta binary.
# https://github.com/dandavison/delta
# Dependencies: curl, tar, make, cargo
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

readonly REPOSITORY='dandavison/delta'
readonly target_path="${2:-/tmp}"
tag="${1:-}"

#===============================================================================
# Functions
#===============================================================================

function main() {
  if [[ -z "${tag}" ]]; then
    tag=$(get_latest_tag)
  fi
  printf "Installing %s %s\n" "${REPOSITORY}" "${tag}"

  download &&
    cd "$(get_asset_dir)" &&
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
  source "${HOME}/.cargo/env"
  make CMAKE_BUILD_TYPE=Release
  cp "target/release/${name}" "/usr/local/bin/${name}"
}

function get_asset_dir() {
  local -r name="${REPOSITORY#*/}"
  local -r download_dir="${target_path}/${name}-${tag#v}"
  printf "%s" "${download_dir}"
}

#===============================================================================
# Execution
#===============================================================================

main
