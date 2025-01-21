#!/usr/bin/env bash
#
# Installs Go programming language.
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
# Variables
#===============================================================================

readonly DEFAULT_GO_VERSION='1.22.1'
readonly install_dir="${HOME}/.go"

#===============================================================================
# Arguments
#===============================================================================

readonly dir_bin="${1:-/usr/bin}"
readonly go_version="${2:-$DEFAULT_GO_VERSION}"

#===============================================================================
# Functions
#===============================================================================

main() {
  printf 'Installing go %s\n' "${go_version}"
  mkdir -p "${install_dir}" &&
    cd "${install_dir}" &&
    install &&
    link &&
    add_to_path
}

install() {
  local -r asset="go${go_version}.linux-amd64.tar.gz"
  local -r source_url="https://go.dev/dl/${asset}"
  curl -JLO "${source_url}" &&
    tar -C "${install_dir}" -xzf "${asset}" &&
    rm "${asset}"
}

link() {
  ln -sfn "${install_dir}/go/bin/go" "${dir_bin}/go" &&
    ln -sfn "${install_dir}/go/bin/gofmt" "${dir_bin}/gofmt"
}

add_to_path() {
  local -r config="${HOME}/.profile"
  printf '%s\nexport PATH="%s:${PATH}"\n' \
    '# Add Go binary to PATH' \
    "$("${dir_bin}"/go env GOPATH)/bin/" \
    >>"${config}"
}

#===============================================================================
# Execution
#===============================================================================

main
