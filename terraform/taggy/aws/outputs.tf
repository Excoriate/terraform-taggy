output "summary" {
  value       = {
    tags = var.tags
    is_acm_limit_set = var.enforce_acm_certificate_limit
  }
  description =<<EOF
  The results after the AWS tags validation has been performed.
  EOF
}
