#!/bin/bash
#
# This script generates, recursively, terraform documentation using 'terraform-docs' binary. For
# more information, see its official documentation: https://github.com/terraform-docs/terraform-docs
# TODO: Pending to discuss, and decide what'll be the approach for 'code-smelling' Terraform code, with DX focus.

set -euo pipefail


#######################################
# Check, and/or install gum. More information,
# see: https://github.com/charmbracelet/gum
# Globals:
#   None
# Arguments:
#   None
#######################################
function check_or_install_gum(){
  if ! command -v gum &> /dev/null; then
    echo "gum is not installed, installing it..."
    brew install gum
  else
    echo "gum is already installed, skipping..."
    echo "Found installed binary in $(which gum)"
    echo
  fi
}

#######################################
# Check, and/or install terraform-docs. More information,
# see: https://github.com/terraform-docs/terraform-docs
# Globals:
#   None
# Arguments:
#   None
#######################################
function check_or_install_terraform_docs(){
  if ! command -v terraform-docs &> /dev/null; then
    echo "terraform-docs is not installed, installing it..."
    brew install terraform-docs
  else
    echo "terraform-docs is already installed, skipping..."
    echo "Found installed binary in $(which terraform-docs)"
    echo
  fi
}

#######################################
# Generate terraform documentation. It
# iterates on each subdirectory found within
# the terraform/modules directory
# and generates the desire documentation,
# running `terraform-docs .`
# Globals:
#   TERRAFORM_MODULES_DIR
#   TERRAFORM_DOCS_CONFIG_FILE
# Arguments:
#   None
#######################################
function generate_terraform_docs(){
  pushd "$TERRAFORM_MODULES_DIR"
  gum spin --spinner dot --title "Generating docs..." -- sleep 1

  for dir in */; do
    if [ -f "$dir/$TERRAFORM_DOCS_CONFIG_FILE" ]; then
      echo "Successfully generated docs for module:  $(gum style --foreground "#04B575" "$dir")"

      cd "$dir"
      terraform-docs .
      cd ..
    else
      gum style --foreground 212 "Ignored module $dir, no $TERRAFORM_DOCS_CONFIG_FILE file found"
    fi
  done

  popd
}


function main() {
  gum style \
	--foreground 212 --border-foreground 212 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Terraform docs generation'

  # Pre-checks
  check_or_install_gum
  check_or_install_terraform_docs

  # Generate docs.
  generate_terraform_docs
}

declare TERRAFORM_DOCS_CONFIG_FILE=".terraform-docs.yml"
declare TERRAFORM_MODULES_DIR="terraform/modules"

main "$@"
