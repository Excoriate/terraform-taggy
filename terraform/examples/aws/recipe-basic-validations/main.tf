module "recipe_basic_validations" {
  source     = "../../../taggy/modules/cloud/aws"
  is_enabled = var.is_enabled

  tags = var.tags
}

