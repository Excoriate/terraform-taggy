resource "null_resource" "enforce_basic_aws" {
  lifecycle {
    precondition {
      condition = alltrue([
        for keys, value in var.tags : substr(keys, 0, 4) != "aws:" ])
      error_message = "Tags cannot contain 'aws:' in their prefix. This prefix is reserved for AWS internal use and can cause problems. Check: https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html."
    }

    precondition {
      condition = alltrue([
        for key, value in var.tags : length(trimspace(value)) > 0 && length(trimspace(value)) <= local.max_tag_value_length ])
      error_message = "Tags must be less than ${local.max_tag_value_length} characters, in case of doubts, please \n refer to the official aws documentation: https://docs.aws.amazon.com/acm/latest/userguide/tags-restrictions.html."
    }

    precondition {
      condition = alltrue([
        for key, value in var.tags : length(trimspace(key)) > 0 && length(trimspace(key)) <= local.max_tag_key_length
      ])
      error_message = "Tags must be less than ${local.max_tag_key_length} characters, in case of doubts, please \n refer to the official aws documentation: https://docs.aws.amazon.com/acm/latest/userguide/tags-restrictions.html."
    }

    precondition {
      condition = var.enforce_acm_certificate_limit ? length(var.tags) <= local.max_number_of_tags_per_acm_certificate: true
      error_message = "The number of tags must be less than ${local.max_number_of_tags_per_acm_certificate} in case of doubts, please \n refer to the official aws documentation: https://docs.aws.amazon.com/acm/latest/userguide/tags-restrictions.html."
    }
  }
}
