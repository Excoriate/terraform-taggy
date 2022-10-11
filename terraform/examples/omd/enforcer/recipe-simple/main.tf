module "recipe_simple" {
  source     = "../../../../taggy/modules/omd/enforcer"
  is_enabled = var.is_enabled


  tags = var.tags

  enforced_tags = {
    "required_in_enforced_tags" = "i_should_exist"
  }
}

