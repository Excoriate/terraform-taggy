locals {
  // control flags
  is_enabled                = var.is_enabled ? 1 : 0
  is_acm_validation_enabled = var.is_enabled && var.enforce_acm_certificate_limit ? 1 : 0

  // Tag restrictions, documented officially by AWS. Ref: https://docs.aws.amazon.com/acm/latest/userguide/tags-restrictions.html
  aws_limits = {
    max_number_of_tags_per_acm_certificate = 50
    max_tag_key_length                     = 127
    max_tag_value_length                   = 255
  }

  // Tags
  validated_tags = var.tags

  // Result
  validation_aws = join("", [for validation in random_uuid.enforce_basic_aws : validation.result if validation != null])
  result         = local.validation_aws != ""
}
