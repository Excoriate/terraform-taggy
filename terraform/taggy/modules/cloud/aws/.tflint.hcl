config {
  module = true
  force = false
}

plugin "aws" {
  enabled = true
  deep_check = true
  // TODO: Pending to define this approach. For automation executions, it's preferred to let the runner set the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
  shared_credentials_file ="~/.aws/credentials"
  // TODO: This can be dynamic, for allowing engineers to locally run this 'checks' without disabling the deep-check in TFLint.
  profile="bolt-dev"
  version = "0.17.1"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

// TODO: It's recommended to allow this rule, and ensure there's a strong version control on the modules referenced.
rule "terraform_module_pinned_source" {
  enabled = false
}
