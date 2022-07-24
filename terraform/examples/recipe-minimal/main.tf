module "recipe_implementation" {
  source = "../../taggy/aws"
  tags   = {
    custom = "mycustomtag"
  }

  // These tags should always be passed
  enforced_tags_default = {
    application = var.application
    name = var.name
    owner = var.owner
  }
}
