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
# set -o xtrace   # Enable shell script debugging mode.

#===============================================================================
# Functions
#===============================================================================

main() {
	printf 'Installing Terraform\n'
	install "${@}" &&
		generate_tab_completion
}

install() {
	curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
	apt update && apt install terraform
}

generate_tab_completion() {
	local -r config_file="${HOME}/.profile"
	cat <<EOF >>"${config_file}"
# Terraform tab completion
# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#enable-tab-completion
autoload -U +X compinit bashcompinit
compinit
bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
EOF
}

#===============================================================================
# Execution
#===============================================================================

main "${@}"
