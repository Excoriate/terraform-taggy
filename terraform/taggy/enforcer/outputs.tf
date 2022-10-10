output "enforced_tags" {
  value = local.tags_enforced
  description = "The tags that are enforced on all resources."
}

output "number_of_enforced_tags" {
  value = local.number_of_tags_enforced
  description = "The number of tags that are enforced on all resources."
}
