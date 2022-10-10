output "enforced_tags" {
  value       = local.tags_enforced
  description = "The tags that are enforced on all resources."
}

output "number_of_enforced_tags" {
  value       = local.number_of_tags_enforced
  description = "The number of tags that are enforced on all resources."
}

output "enforcer_result" {
  value       = local.result
  description = <<EOF
The result of the tag enforcer, their rules, and validations. Possible values and their meaning are:
  - "PASS" - All resources have the required tags, and have passedd all validations.
  - "FAIL" - One or more resources are missing required tags, or have failed one or more validations.
EOF
}
