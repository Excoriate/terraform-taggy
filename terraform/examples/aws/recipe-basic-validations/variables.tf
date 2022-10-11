variable "is_enabled" {
  type        = bool
  description = "Enable or disable the module"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}

