#!/usr/bin/env bash
#
# Downloads Neovim configuration.
# Dependencies: git
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

readonly DIR_CONFIG="${HOME}/.config"
readonly REPOSITORY_URL='https://github.com/michalsvorc/nvim-config'

#===============================================================================
# Arguments
#===============================================================================

readonly branch="${1:-main}"

#===============================================================================
# Execution
#===============================================================================

git clone \
  --branch "${branch}" \
  "${REPOSITORY_URL}" "${DIR_CONFIG}/nvim"
