is_enabled = true

tags = {
  "application"               = "terratest"
  "environment"               = "test"
  "i_will_trigger_a_failure"  = " true" // not trimmed
  "required_in_enforced_tags" = "i_should_exist"
}

enforce_all_keys_and_values_are_filled = false
enforce_no_whitespaces_in_tag_values   = true
