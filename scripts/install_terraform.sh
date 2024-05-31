#!/usr/bin/env bash
#
# Installs Terraform binary.
# https://developer.hashicorp.com/terraform/install#linux
# Dependencies: gpg, tee
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
set -o xtrace   # Enable shell script debugging mode.

#===============================================================================
# Functions
#===============================================================================

main() {
  printf 'Installing Terraform\n'
  install "${@}"
}

install() {
  wget -O- https://apt.releases.hashicorp.com/gpg |
    sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpgecho "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" |
    sudo tee /etc/apt/sources.list.d/hashicorp.listsudo apt update &&
    sudo apt install terraform
}

#===============================================================================
# Execution
#===============================================================================

main "${@}"
