variable tags  {
  type = map(string)
  description =<<EOF
  A map of variable tags. It automatically ensures that there is
conventional data passed, like 'application', 'name' and 'version', regardless of
the option or configuration passed through the input variable
var.config
EOF
  validation {
    condition = alltrue([
    for keys, value in var.tags : substr(value, 0, 4) != "aws:"
      ])
    error_message = "Tags cannot contain 'aws:' in their prefix. This prefix is reserved for AWS internal use and can cause problems. Check: https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html."
  }

  validation {
    condition = alltrue([
    for key, value in var.tags : length(regexall("[<>%&\\?/]", tostring(key))) == 0
      ])
    error_message = "Tag names can't contain these characters: <, >, %, &, \\, ?, /. According to: https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources?tabs=json."
  }

  validation {
    condition = alltrue([
    for key, value in var.tags : (length(trimspace(value)) > 0 && length(trimspace(value)) < 255)
    ])
    error_message = "Tags must be present and maximum size of 255 chars, in doubt please check: https://docs.aws.amazon.com/acm/latest/userguide/tags-restrictions.html \n Since AWS allows 255 chars versus Azure allowing 256 chars we are keeping the the lowest so we can be compatible with both."
  }
}


variable "enforced_tags"{
  type = map(string)
  default = {}
  description =<<EOF
Set of tags, that will be enforced. The list of enforced tags are:
- name (the name of the resource)
- application (application, service or feature)
- owner (company or person accountable for these resources)
EOF
  validation {
    condition = alltrue([
      length(trimspace(lookup(var.enforced_tags, "name", ""))) > 0,
      length(trimspace(lookup(var.enforced_tags, "application", ""))) > 0,
      length(trimspace(lookup(var.enforced_tags, "owner", ""))) > 0
    ])
    error_message = "Tags name, application and owner are always mandatory."
  }
}

variable "config"{
  type =object({
    force_lower_case = bool # If true, it'll ensure that all tags are lower case.
    force_upper_case = bool # If true, it'll ensure that all tags are upper case.
  })
  default = {
    force_lower_case = false
    force_upper_case = false
  }
  description =<<EOF
Configuration of this module.
EOF
}
