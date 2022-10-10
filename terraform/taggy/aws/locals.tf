locals {
  // Control flags
  // 1. Set lower/upper case options, if set.
  is_enforced_tags_default_enabled = var.config.enable_default_enforcement && var.


  // Enforced default tags option
  name = lookup(var.tags, "name", null) == null ? "" : trimspace(var.tags["name"])
  application = lookup(var.tags, "application", null) == null ? "" : trimspace(var.tags["application"])
  owner = lookup(var.tags, "owner", null) == null ? "" : trimspace(var.tags["owner"])

  // Tags resolved
}
