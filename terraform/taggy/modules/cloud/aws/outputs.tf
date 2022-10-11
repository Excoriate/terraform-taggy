output "summary" {
  value = {
    tags             = var.tags
    is_acm_limit_set = var.enforce_acm_certificate_limit
  }
  description = <<EOF
  The results after the AWS tags validation has been performed.
  EOF
}


output "aws_limits" {
  value       = local.aws_limits
  description = <<EOF
AWS limits applied for AWS tags validations, and restrictions. For more
information, see the AWS documentation about tag restrictions: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#tag-restrictions
EOF
}
