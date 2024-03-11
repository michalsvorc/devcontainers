#!/usr/bin/env bash
#
# Installs Go programming language.
# https://github.com/Schniz/fnm
# https://github.com/Schniz/fnm?tab=readme-ov-file#installation
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

dir_bin="${1:-${HOME}/.local/bin}"
install_dir="${HOME}/.go"

GO_VERSION='1.19.2'

#===============================================================================
# Functions
#===============================================================================

main() {
  printf 'Installing go %s\n' "${GO_VERSION}"
  mkdir -p "${install_dir}" &&
    install &&
    link &&
    add_to_path
}

install() {
  local -r asset="go${GO_VERSION}.linux-amd64.tar.gz"
  curl -JLO "https://go.dev/dl/${asset}" &&
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
