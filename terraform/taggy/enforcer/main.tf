locals {
  tags_enforced = var.enforced_tags
  number_of_tags_enforced = length(keys(var.enforced_tags))
}
