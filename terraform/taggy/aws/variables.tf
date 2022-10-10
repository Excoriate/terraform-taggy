variable "tags" {
  type        = map(string)
  description = <<EOF
 An arbitrary map of tags (key-value pairs) to assign to the resource.
These set of modules are validated against known, and documented constraints in AWS. For more
information, see the AWS documentation about tags: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html
EOF
}

variable "enforce_acm_certificate_limit" {
  type        = bool
  default     = false
  description = <<EOF
Based on the official AWS documentation, there's a hard limit for ACM certificate tags. For
more information, please refer to: https://docs.aws.amazon.com/acm/latest/userguide/tags-restrictions.html
EOF
}
