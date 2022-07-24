module "implementation_minimal" {
  source = "../../taggy/aws"
  tags   = {
    custom = "mycustomtag"
  }

  // These tags should always be passed
  enforced_tags = {
    application = var.application
    name = var.name
    owner = var.owner
  }
}
