variable "is_enabled" {
  type        = bool
  description = "Enable or disable the module"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}


module "recipe_simple_pass" {
  source     = "../../../../taggy/modules/omd/enforcer"
  is_enabled = var.is_enabled


  tags = var.tags

  enforced_tags = {
    "required_in_enforced_tags" = "i_should_exist"
  }
}

