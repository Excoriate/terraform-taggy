variable "is_enabled" {
  type        = bool
  description = "Enable or disable the module"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}

// Custom checks, and enforcements to validate and enrich the testing scenarios.
variable "enforce_all_keys_and_values_are_filled" {
  type        = bool
  description = "Enforce all keys and values are filled"
}

variable "enforce_no_whitespaces_in_tag_values" {
  type        = bool
  description = "Enforce no whitespaces in tag values"
}
