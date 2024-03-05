#!/usr/bin/env bash
#
# Installs fnm (Fast Node Manager).
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
dir_zsh_completions="${2:-${HOME}/.local/share/zsh/site-functions}"

#===============================================================================
# Funtions
#===============================================================================

main() {
  printf "Installing fnm\n"
  install
  set_use_on_cd
  generate_completions
}

install() {
  curl -fsSL 'https://fnm.vercel.app/install' |
    bash -s -- \
      --install-dir "${dir_bin}" \
      --skip-shell
}

set_use_on_cd() {
  local -r target_config="${HOME}/.profile"

  printf '\n%s\n%s\n' \
    '# https://github.com/Schniz/fnm' \
    'eval "$(fnm env --use-on-cd)"' \
    >>"${target_config}"
}

generate_completions() {
  "${dir_bin}/fnm" completions --shell zsh \
    >"${dir_zsh_completions}/_fnm"
}

#===============================================================================
# Execution
#===============================================================================

main
