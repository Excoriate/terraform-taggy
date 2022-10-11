variable "tags" {
  type        = map(string)
  description = <<EOF
Set of tags passed by the caller module. This set of tags will be validated against the set of rules described by
this module.
EOF
}

variable "enforced_tags" {
  type        = map(string)
  default     = {}
  description = <<EOF
  A map of tags to enforce on all resources.  This is useful for tagging resources with a common set of tags.
If this set of tags aren't set, this module will trigger an error, in order to be managed
by the upstream module that sets these tags.
  EOF
}

variable "enforce_rules_basics" {
  type = object({
    enforce_all_keys_and_values_are_filled = bool
    enforce_no_whitespaces_in_tag_values   = bool
  })
  default = {
    enforce_all_keys_and_values_are_filled = false
    enforce_no_whitespaces_in_tag_values   = false
  }
  description = <<EOF
  A set of rules to enforce on all tags.  This is useful for enforcing a common set of rules on all tags.
with likely validations commonly used for cloud resource tagging, and finOps.
  EOF
}

variable "enforced_rules_format" {
  type = object({
    enforce_lowercase_tag_keys    = bool
    enforce_uppercase_tag_keys    = bool
    enforce_lowercase_tag_values  = bool
    enforce_uppercase_tag_values  = bool
    enforce_camel_case_in_values  = bool
    enforce_camel_case_in_keys    = bool
    enforce_snake_case_in_keys    = bool
    enforce_snake_case_in_values  = bool
    enforce_kebab_case_in_keys    = bool
    enforce_kebab_case_in_values  = bool
    enforce_no_escaped_characters = bool
  })

  default = {
    enforce_lowercase_tag_keys    = false
    enforce_uppercase_tag_keys    = false
    enforce_lowercase_tag_values  = false
    enforce_uppercase_tag_values  = false
    enforce_camel_case_in_values  = false
    enforce_camel_case_in_keys    = false
    enforce_snake_case_in_keys    = false
    enforce_snake_case_in_values  = false
    enforce_kebab_case_in_keys    = false
    enforce_kebab_case_in_values  = false
    enforce_no_escaped_characters = true
  }

  validation {
    condition     = var.enforced_rules_format.enforce_lowercase_tag_keys == false || var.enforced_rules_format.enforce_uppercase_tag_keys == false
    error_message = "You can't enforce both lowercase and uppercase tag keys at the same time."
  }

  validation {
    condition     = var.enforced_rules_format.enforce_lowercase_tag_values == false || var.enforced_rules_format.enforce_uppercase_tag_values == false
    error_message = "You can't enforce both lowercase and uppercase tag values at the same time."
  }


  description = <<EOF
  A map of rules to enforce on all resources.  This is useful for tagging resources with a common set of rules.
These enforced rules act upon the var.enforced_tags map, and aims to enforce high-level/general set of
rules that applies either for tag keys, or their respective values.
The rules currently enforced are:
- enforce_lowercase_tag_keys: Ensures that all tag keys are lowercase. Default is false.
- enforce_uppercase_tag_keys: Ensures that all tag keys are uppercase. Default is false.
- enforce_lowercase_tag_values: Ensures that all tag values are lowercase. Default is false.
- enforce_uppercase_tag_values: Ensures that all tag values are uppercase. Default is false.
- enforce_camel_case_in_values: Ensures that all tag values are camel case. Default is false.
- enforce_camel_case_in_keys: Ensures that all tag keys are camel case. Default is false.
- enforce_snake_case_in_keys: Ensures that all tag keys are snake case. Default is false.
- enforce_snake_case_in_values: Ensures that all tag values are snake case. Default is false.
- enforce_kebab_case_in_keys: Ensures that all tag keys are kebab case. Default is false.
- enforce_kebab_case_in_values: Ensures that all tag values are kebab case. Default is false.
- enforce_no_escaped_characters: Ensures that all tag keys and values don't contain escaped characters. Default is true.
  EOF
}

variable "enforce_no_allowed_in_tags" {
  type = object({
    enforce_no_spaces_in_values                    = bool
    enforce_no_spaces_in_keys                      = bool
    enforce_no_special_characters_in_values        = bool
    enforce_no_special_characters_in_keys          = bool
    enforce_no_special_characters_in_values_except = list(string)
    enforce_no_empty_values                        = bool
    enforce_no_empty_keys                          = bool
  })
  default = {
    enforce_no_spaces_in_values                    = false
    enforce_no_spaces_in_keys                      = false
    enforce_no_special_characters_in_values        = false
    enforce_no_special_characters_in_keys          = false
    enforce_no_empty_values                        = false
    enforce_no_empty_keys                          = false
    enforce_no_special_characters_in_values_except = []
  }
  description = <<EOF
  A map of rules to enforce on all resources.  This is useful for tagging resources with a common set of rules. These set of rules
aims to provide a set a pre-defined validations, that catch common mistakes when tagging resources. The list of allowed rules
are described as follows:
- enforce_no_spaces_in_values: Ensures that all tag values don't contain spaces. Default is false.
- enforce_no_spaces_in_keys: Ensures that all tag keys don't contain spaces. Default is false.
- enforce_no_special_characters_in_values: Ensures that all tag values don't contain special characters. Default is false.
- enforce_no_special_characters_in_values_except: Ensures that all tag values don't contain special characters, except for the ones specified in this list. Default is [].
- enforce_no_special_characters_in_keys: Ensures that all tag keys don't contain special characters. Default is false.
- enforce_no_empty_values: Ensures that all tag values don't contain empty values. Default is false.
- enforce_no_empty_keys: Ensures that all tag keys don't contain empty keys. Default is false.
  EOF
}

variable "enforce_custom_format" {
  type = object({
    enforce_prefix_in_keys     = string
    enforce_suffix_in_keys     = string
    enforce_max_number_of_tags = number
    enforce_no_allowed_values  = list(string)
    enforce_reserved_tags      = list(string)
  })
  default = {
    enforce_prefix_in_keys     = ""
    enforce_suffix_in_keys     = ""
    enforce_max_number_of_tags = 0
    enforce_no_allowed_values  = []
    enforce_reserved_tags      = []
  }
  description = <<EOF
  A map of rules to enforce on all resources. When OMD data, and tags is required, there are custom rules that are normally :
enforced, for cost-allocation, and finops purposes. The list of allowed rules are described as follows:
- enforce_prefix_in_keys: Ensures that all tag keys start with a specific prefix. Default is "".
- enforce_suffix_in_keys: Ensures that all tag keys end with a specific suffix. Default is "".
- enforce_max_number_of_tags: Ensures that all resources don't have more than a specific number of tags. Default is 0.
- enforce_no_allowed_values: Ensures that all resources don't have any of the values specified in this list. Default is [].
- enforce_reserved_tags: Ensures that all resources don't have any of the tags specified in this list. Default is [].
  EOF
}

variable "is_enabled" {
  type        = bool
  description = <<EOF
Whether to enable this module, its validations and eventual resources, or not.
  EOF
}
