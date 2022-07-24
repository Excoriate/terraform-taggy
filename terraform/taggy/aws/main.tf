locals {

  // Main result/output object
  output_context = {
    tags = merge(var.tags, var.enforced_tags)
    metadata = {}
  }
}
