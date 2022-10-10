locals {
  output_context = {
    tags = merge(var.tags, var.enforced_tags_default)
  }

  config_normalised = {
    attached_doc_into_messages = var.config.enforced_tags_convention_doc_ref == null ? "" : "- for more information about this convention, please refer to the following doc: ${var.config.enforced_tags_convention_doc_ref}"
  }
}


resource "null_resource" "run_validations_on_enforced_tags" {
  lifecycle {
    /*
     * These set of validations are always performed where the `config.fail_on_enforced_tags_default` is set to `true`.
     * As a convention, it's enforced by default the following tags:
      * - application
      * - environment
      * - name
      * - owner
     */
    precondition {
      condition = var.config.fail_on_enforced_tags_default ? alltrue([
length(trimspace(lookup(var.enforced_tags_default, "name", ""))) > 0,
length(trimspace(lookup(var.enforced_tags_default, "application", ""))) > 0,
length(trimspace(lookup(var.enforced_tags_default, "environment", ""))) > 0,
length(trimspace(lookup(var.enforced_tags_default, "owner", ""))) > 0
]) : true
      error_message = "The enforced tags (default) validation is set in `true` and some required (conventional) attributes are missing."
    }

    /*
     * These set of validations are always performed where the `config.fail_on_enforced_tags` is set to `true`.
     * This configuration is optional, and aims to enforce specific tags based on forced internal (teams, companies, etc.) conventions.
     * This validation is divided into two parts: here, it's checking whether the configuration is at least consistent.
     */
    precondition {
      condition = var.config.fail_on_enforced_tags ? alltrue([var.enforced_tags_custom != null, length(keys(var.enforced_tags_custom)) > 0, length(var.config.enforced_tags_custom_keys) > 0 , length(var.config.enforced_tags_custom_keys) == length(keys(var.enforced_tags_custom))]): true

      error_message = "The enforced tags validation is set in `true` for the custom enforced tags, but the configuration passed is inconsistent."
    }

    /*
     * These set of validations are always performed where the `config.fail_on_enforced_tags` is set to `true`.
     * This validation ensures that the keys declared as `enforced`, exists in the object that holds this configuration, which is
      * the `enforced_tags_custom` object (defined in the input variable `var.enforced_tags_custom`)
    */
    precondition {
      condition = var.config.fail_on_enforced_tags ? length([ for tag in var.config.enforced_tags_custom_keys: tag if lookup(var.enforced_tags_custom, trimspace(tag), null) != null]) == length(keys(var.enforced_tags_custom)) : true
      error_message = "Some enforced (custom) tags keys are missing in the `var.enforced_tags_custom` that were defined in the `var.config.enforced_tags_custom_keys` ${local.config_normalised.attached_doc_into_messages}."
    }

  }
}

resource "null_resource" "user_tags" {
  lifecycle {
    precondition {
      condition = alltrue([
      for keys, value in var.tags : substr(value, 0, 4) != "aws:"
        ])
      error_message = "Tags cannot contain 'aws:' in their prefix. This prefix is reserved for AWS internal use and can cause problems. Check: https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html."
    }

    precondition {
      validation {
        condition = alltrue([
        for key, value in var.tags : (length(trimspace(value)) > 0 && length(trimspace(value)) < 255)
        ])
        error_message = "Tags must be present and maximum size of 255 chars, in doubt please check: https://docs.aws.amazon.com/acm/latest/userguide/tags-restrictions.html \n Since AWS allows 255 chars versus Azure allowing 256 chars we are keeping the the lowest so we can be compatible with both."
      }
    }
  }
}
