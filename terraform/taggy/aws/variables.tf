variable tags  {
  type = map(string)
  description =<<EOF
 An arbitrary map of tags (key-value pairs) to assign to the resource.
These set of modules are validated against known, and documented constraints in AWS. For more
information, see the AWS documentation about tags: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html
EOF
}


variable "enforced_tags_default"{
  type = map(string)
  default = {}
  description =<<EOF
Set of tags that are enforced by the majority of the applications. If
the input variable var.enable_default_enforcement is set to true, the
following tags will be mandatory, and required:
- name (the name of the resource)
- application (application, service or feature)
- owner (company or person accountable for these resources)
EOF
}

# TODO: Make, somehow, dynamic and "configurable" the enforced tags documentation.
variable "enforced_tags" {
 type = map(string)
  default = null
  description =<<EOF
Set of tags, based on the specific module or company's needs. Its enforcement is
is mandatory. For more information about the list of enforced tags, see the following
documentation:
EOF
}

variable "config"{
  type =object({
    force_lower_case = bool # If true, it'll ensure that all tags are lower case.
    force_upper_case = bool # If true, it'll ensure that all tags are upper case.
    enable_default_enforcement = bool
  })
  default = {
    force_lower_case = false
    force_upper_case = false
    enable_default_enforcement = false
  }
  description =<<EOF
Configuration for the tags module. The following options are available:
- force_lower_case: If true, it'll ensure that all tags are lower case.
- force_upper_case: If true, it'll ensure that all tags are upper case.
- enable_default_enforcement: If true, it'll enforce the default tags. The default tags
are the following:
  - name (the name of the resource)
  - application (application, service or feature)
  - owner (company or person accountable for these resources)
EOF
}
