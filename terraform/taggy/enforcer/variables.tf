variable "enforced_tags" {
  type = map(string)
  default = {}
  description = <<EOF
  A map of tags to enforce on all resources.  This is useful for tagging resources with a common set of tags.
If this set of tags aren't set, this module will trigger an error, in order to be managed
by the upstream module that sets these tags.
  EOF
  validation {
    condition = length(keys(var.enforced_tags)) == 0 || length(keys(var.enforced_tags)) == length(keys(var.enforced_tags))
    error_message = "The enforced_tags map must be set."
  }
}
