locals {
  // Tag restrictions, documented officially by AWS. Ref: https://docs.aws.amazon.com/acm/latest/userguide/tags-restrictions.html
  max_number_of_tags_per_acm_certificate = 50
  max_tag_key_length                  = 127
  max_tag_value_length                = 255
}
