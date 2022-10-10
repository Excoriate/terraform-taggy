is_enabled = true

tags = {
  "application"               = "terratest"
  "environment"               = "test"
  "i_will_trigger_a_failure"  = " true" // not trimmed
  "required_in_enforced_tags" = "i_should_exist"
}
