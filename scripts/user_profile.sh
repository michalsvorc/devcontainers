#!/usr/bin/env bash
#
# Downloads and initializes the user profile.
# Dependencies: git, bash
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

readonly REPOSITORY_URL='https://github.com/michalsvorc/profile'

readonly dir_profile="${1-$HOME/.local/profile}"
readonly branch="${2:-main}"

#===============================================================================
# Execution
#===============================================================================

git clone \
  --recurse-submodules \
  --depth 1 \
  --branch "${branch}" \
  "${REPOSITORY_URL}" "${dir_profile}" &&
  bash "${dir_profile}/scripts/init.sh"
