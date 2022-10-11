output "summary" {
  value = {
    tags                    = var.tags
    tags_enforced           = var.enforced_tags
    number_of_tags_enforced = length(var.enforced_tags)
    number_of_tags          = length(var.tags)
  }
  description = <<EOF
  This output is used to show the tags and enforced tags
  EOF
}


// TODO: Figure out a way to output the overall state of these validations, considering that a failure exists with 1.
output "result" {
  value       = local.validation_result ? "PASS" : "FAIL"
  description = <<EOF
The result of the tag enforcer, their rules, and validations. Possible values and their meaning are:
  - "PASS" - All resources have the required tags, and have passedd all validations.
  - "FAIL" - One or more resources are missing required tags, or have failed one or more validations.
EOF
}
