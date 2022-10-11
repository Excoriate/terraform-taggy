variable "tags" {
  type        = map(string)
  description = <<EOF
  An arbitrary map of tags (key-value pairs) that will be applied to all resources that support tags.
These tags will be subject of validation, and will be used to enforce the presence of specific tags,
expected format, taxonomy, and compliance with the cloud-specific tag policies.
  EOF
}

variable "enable_aws_tags_validations" {
  type = object({
    enable                     = bool
    enable_acm_tags_validation = bool
  })
  description = <<EOF
If set, it runs a set of validations considering the AWS tag restrictions. These validations includes
the following:
- AWS maximum tag limit for ACM certificates
- AWS maximum length for tags
- AWS maximum length of tag values
For more information, please refer to the official AWS documentation: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#tag-restrictions

E.g: var.enforce_aws_tags = {
  enable = true
  enable_acm_tags_validation = true
}
in order to enable the AWS tags validation for all resources, without the ACM tags validation.
EOF

  default = {
    enable                     = false
    enable_acm_tags_validation = false
  }
}

variable "enable_enforced_tags" {
  type        = map(string)
  description = <<EOF
If set, it'll ensure that these tags are present in the tags declared in the
var.tags variable. If the tag is not present, it will fail the validation.
E.g: var.enforced_tags = {
  "tag1" = "value1"
  "tag2" = "value2"
}
EOF
  default     = {}
}
