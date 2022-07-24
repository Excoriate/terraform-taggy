locals {
  // Always enforced and expected tags / metadata
  name = lookup(var.tags, "name", null) == null ? "" : trimspace(var.tags["name"])
  application = lookup(var.tags, "application", null) == null ? "" : trimspace(var.tags["application"])
  owner = lookup(var.tags, "owner", null) == null ? "" : trimspace(var.tags["owner"])
}
