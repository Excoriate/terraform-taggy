locals {
  // Control flags
  is_enabled = toset(var.is_enabled ? ["true"] : [])

  tags_enforced           = var.enforced_tags
  number_of_tags_enforced = length(keys(var.enforced_tags))

  // Automatically, add a timestamp.
}
