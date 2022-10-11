locals {
  validation_basics          = join("", [for tag in random_uuid.enforce_basic_aws : tag.result if tag != null])
  validation_length          = join("", [for tag in random_uuid.enforce_length_validation : tag.result if tag != null])
  validation_acm_certificate = join("", [for tag in random_uuid.enforce_acm_certificate_validations : tag.result if tag != null])

  validation_result = alltrue([length(local.validation_aws) > 0, length(local.validation_length) > 0, length(local.validation_acm_certificate) > 0])
}

resource "random_uuid" "enforce_basic_aws" {
  count = local.is_enabled

  lifecycle {
    precondition {
      condition = alltrue([
      for keys, value in var.tags : substr(keys, 0, 4) != "aws:"])
      error_message = "Tags cannot contain 'aws:' in their prefix. This prefix is reserved for AWS internal use and can cause problems. Check: https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html."
    }
  }
}

resource "random_uuid" "enforce_length_validation" {
  count = local.is_enabled

  lifecycle {
    precondition {
      condition = alltrue([
      for key, value in var.tags : length(trimspace(value)) > 0 && length(trimspace(value)) <= local.aws_limits.max_tag_value_length])
      error_message = "Tags must be less than ${local.aws_limits.max_tag_value_length} characters, in case of doubts, please \n refer to the official aws documentation: https://docs.aws.amazon.com/acm/latest/userguide/tags-restrictions.html."


      precondition {
        condition = alltrue([
          for key, value in var.tags : length(trimspace(key)) > 0 && length(trimspace(key)) <= local.aws_limits.max_tag_key_length
        ])
        error_message = "Tags must be less than ${local.aws_limits.max_tag_key_length} characters, in case of doubts, please \n refer to the official aws documentation: https://docs.aws.amazon.com/acm/latest/userguide/tags-restrictions.html."
      }
    }
  }
}

resource "random_uuid" "enforce_acm_certificate_validations" {
  count = local.is_acm_validation_enabled

  lifecycle {
    precondition {
      condition     = var.enforce_acm_certificate_limit ? length(var.tags) <= local.aws_limits.max_number_of_tags_per_acm_certificate : true
      error_message = "The number of tags must be less than ${local.aws_limits.max_number_of_tags_per_acm_certificate} in case of doubts, please \n refer to the official aws documentation: https://docs.aws.amazon.com/acm/latest/userguide/tags-restrictions.html."
    }
  }
}
