variable "is_enabled" {
  type        = bool
  description = "Enable or disable the module"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}


module "recipe_simple_pass" {
  source = "../../../../taggy/omd/enforcer"
  is_enabled = var.is_enabled

  // Tags to be validated.
  enforced_tags = merge(
    var.tags,
    // Enforced tags.
    {
      "name" = "recipe_simple_pass"
    }
  )

}

