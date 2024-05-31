#!/usr/bin/env bash
#
# Installs AWS CLI binary.
# https://aws.amazon.com/cli/
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
# Dependencies: curl, unzip
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

readonly REPOSITORY='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'
readonly DOWNLOAD_PATH='/tmp/awscliv2.zip'
readonly EXTRACT_DIR='/opt'

#===============================================================================
# Functions
#===============================================================================

main() {
  printf 'Installing %s\n' "${REPOSITORY}"
  download &&
    unzip_asset &&
    install "${@}"
}

download() {
  curl -L "${REPOSITORY}" -o "${DOWNLOAD_PATH}"
}

unzip_asset() {
  unzip \
    -o \
    -q \
    "${DOWNLOAD_PATH}" \
    -d "${EXTRACT_DIR}" &&
    rm "${DOWNLOAD_PATH}"
}

install() {
  "${EXTRACT_DIR}/aws/install" "${@}"
}

#===============================================================================
# Execution
#===============================================================================

main "${@}"
