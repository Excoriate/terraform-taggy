locals {
  // Control flags
  is_enabled = toset(var.is_enabled ? ["true"] : [])
}
