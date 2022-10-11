output "summary" {
  value = {
    tags               = var.tags
    is_acm_limit_set   = var.enforce_acm_certificate_limit
    aws_limits_applied = local.aws_limits
  }
  description = <<EOF
  The results after the AWS tags validation has been performed. About the AWS limits, the
AWS limits applied for AWS tags validations, and restrictions. For more
information, see the AWS documentation about tag restrictions: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#tag-restrictions
  EOF
}

output "result" {
  value       = local.result ? "PASS" : "FAIL"
  description = <<EOF
  The result of the tag validation, their rules, and validations. Possible values and their meaning are:
  - "PASS" - All resources have the required tags, and have passedd all validations.
  - "FAIL" - One or more resources are missing required tags, or have failed one or more validations.
EOF
}

