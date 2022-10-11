module "recipe_basic_validations" {
  source     = "../../../../taggy/modules/omd/enforcer"
  is_enabled = var.is_enabled


  tags = var.tags

  enforced_tags = {
    "required_in_enforced_tags" = "i_should_exist"
  }

  // Custom checks, per scenario.
  enforce_rules_basics = {
    enforce_all_keys_and_values_are_filled = var.enforce_all_keys_and_values_are_filled
    enforce_no_whitespaces_in_tag_values   = var.enforce_no_whitespaces_in_tag_values
  }
}
