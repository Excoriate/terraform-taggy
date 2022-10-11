locals {
  // Set of rules to enforce
  validation_basics        = join("", [for tag in null_resource.enforced_rules_basic.*.id : tag["id"] if tag["id"] != null])
  validation_tags_enforced = join("", [for tag in null_resource.enforced_tags.*.id : tag["id"] if tag["id"] != null])
}

resource "null_resource" "enforced_rules_basic" {
  for_each = local.is_enabled

  lifecycle {
    precondition {
      condition     = var.enforce_rules_basics.enforce_all_keys_and_values_are_filled == false || length(var.tags) > 0 && length(keys(var.tags)) > 0 && length(values(var.tags)) > 0 && length([for k, v in var.tags : v if length(v) > 0]) == length(values(var.tags))
      error_message = "The var.tags should have keys, values and all its values should be non-empty."
    }

    precondition {
      condition     = var.enforce_rules_basics.enforce_no_whitespaces_in_tag_values == false || length([for k, v in var.tags : v if length(v) > 0 && length(regexall("\\s", v)) > 0]) == 0
      error_message = "The var.tags should not have whitespaces in its values, consider that this validation consider valid an empty string that is trimmed."
    }
  }
}

resource "null_resource" "enforced_tags" {
  precondition {
    condition     = length(var.enforced_tags) == 0 || length([for k, v in var.enforced_tags : v if length(v) > 0 && v == trimspace(v)]) == length(values(var.enforced_tags)) && length([for k, v in var.enforced_tags : v if length(v) > 0 && v == trimspace(v)]) == length([for k, v in var.enforced_tags : v if length(v) > 0 && v == trimspace(v) && lookup(var.tags, k, "") != ""])
    error_message = "The var.tags should have all the keys declared in the var.enforced_tags map, and the values should not be empty; \n currently, some tags are missing, therefore this error."
  }
}


resource "null_resource" "enforced_rules_format" {
  for_each = local.is_enabled

  lifecycle {
    precondition {
      condition     = var.enforced_rules_format.enforce_lowercase_tag_keys == false || length(regexall("[a-z0-9_]+", keys(var.tags)[0])) == 1
      error_message = "The tags map keys must be all lowercase."
    }

    precondition {
      condition     = var.enforced_rules_format.enforce_uppercase_tag_keys == false || length(regexall("[A-Z0-9_]+", keys(var.tags)[0])) == 1
      error_message = "The tags map keys must be all uppercase."
    }

    precondition {
      condition     = var.enforced_rules_format.enforce_lowercase_tag_values == false || length(regexall("[a-z0-9_]+", values(var.tags)[0])) == 1
      error_message = "The tags map values must be all lowercase."
    }

    precondition {
      condition     = var.enforced_rules_format.enforce_uppercase_tag_values == false || length(regexall("[A-Z0-9_]+", values(var.tags)[0])) == 1
      error_message = "The tags map values must be all uppercase."
    }

    precondition {
      condition     = var.enforced_rules_format.enforce_camel_case_in_keys == false || length(regexall("[a-z0-9]+([A-Z0-9][a-z0-9]+)+", keys(var.tags)[0])) == 1
      error_message = "The tags map keys must be all camel case."
    }

    precondition {
      condition     = var.enforced_rules_format.enforce_camel_case_in_values == false || length(regexall("[a-z0-9]+([A-Z0-9][a-z0-9]+)+", values(var.tags)[0])) == 1
      error_message = "The tags map values must be all camel case."
    }

    precondition {
      condition     = var.enforced_rules_format.enforce_snake_case_in_keys == false || length(regexall("[a-z0-9]+(_[a-z0-9]+)+", keys(var.tags)[0])) == 1
      error_message = "The tags map keys must be all snake case."
    }

    precondition {
      condition     = var.enforced_rules_format.enforce_snake_case_in_values == false || length(regexall("[a-z0-9]+(_[a-z0-9]+)+", values(var.tags)[0])) == 1
      error_message = "The tags map values must be all snake case."
    }

    precondition {
      condition     = var.enforced_rules_format.enforce_kebab_case_in_keys == false || length(regexall("[a-z0-9]+(-[a-z0-9]+)+", keys(var.tags)[0])) == 1
      error_message = "The tags map keys must be all kebab case."
    }

    precondition {
      condition     = var.enforced_rules_format.enforce_kebab_case_in_values == false || length(regexall("[a-z0-9]+(-[a-z0-9]+)+", values(var.tags)[0])) == 1
      error_message = "The tags map values must be all kebab case."
    }

    precondition {
      condition     = var.enforced_rules_format.enforce_no_escaped_characters == false || length(regexall("[^<>&%\\\\?/]+", keys(var.tags)[0])) == 1
      error_message = "The tags map keys must not contain any of these characters: <, >, %, &, \\, ?, /."
    }
  }
}

resource "null_resource" "enforce_not_allowed_in_tags" {
  for_each = local.is_enabled

  lifecycle {
    precondition {
      condition     = var.enforce_no_allowed_in_tags.enforce_no_spaces_in_values == false || length(regexall("[^ ]+", values(var.tags)[0])) == 1
      error_message = "The tags map values must not contain spaces."
    }

    precondition {
      condition     = var.enforce_no_allowed_in_tags.enforce_no_spaces_in_keys == false || length(regexall("[^ ]+", keys(var.tags)[0])) == 1
      error_message = "The tags map keys must not contain spaces."
    }

    precondition {
      condition     = var.enforce_no_allowed_in_tags.enforce_no_special_characters_in_values == false || length(var.enforce_no_allowed_in_tags.enforce_no_special_characters_in_values_except) == 0 ? length(regexall("[^!@#\\$%^&*()_+{}|:\"<>?]+", values(var.tags)[0])) == 1 : length(regexall("[^${var.enforce_no_allowed_in_tags.enforce_no_special_characters_in_values_except}]+", values(var.tags)[0])) == 1
      error_message = "The tags map values must not contain any special characters except the ones specified in the var.enforce_no_allowed_in_tags.enforce_no_special_characters_in_values_except variable."
    }

    precondition {
      condition     = var.enforce_no_allowed_in_tags.enforce_no_empty_values == false || length(regexall("[^ ]+", values(var.tags)[0])) == 1
      error_message = "The tags map values must not be empty."
    }

    precondition {
      condition     = var.enforce_no_allowed_in_tags.enforce_no_empty_keys == false || length(regexall("[^ ]+", keys(var.tags)[0])) == 1
      error_message = "The tags map keys must not be empty."
    }
  }
}

resource "null_resource" "enforced_rules_custom" {
  for_each = local.is_enabled

  lifecycle {
    precondition {
      condition     = var.enforce_custom_format.enforce_prefix_in_keys == "" || length(regexall("${var.enforce_custom_format.enforce_prefix_in_keys}.*", keys(var.tags)[0])) == 1
      error_message = "The tags map keys must contain the prefix ${var.enforce_custom_format.enforce_prefix_in_keys}."
    }

    precondition {
      condition     = var.enforce_custom_format.enforce_suffix_in_keys == "" || length(regexall(".*${var.enforce_custom_format.enforce_suffix_in_keys}", keys(var.tags)[0])) == 1
      error_message = "The tags map keys must contain the suffix ${var.enforce_custom_format.enforce_suffix_in_keys}."
    }

    precondition {
      condition     = var.enforce_custom_format.enforce_max_number_of_tags == 0 || length(var.tags) <= var.enforce_custom_format.enforce_max_number_of_tags
      error_message = "The tags map must contain less or equal than ${var.enforce_custom_format.enforce_max_number_of_tags} tags."
    }

    precondition {
      condition     = length(var.enforce_custom_format.enforce_no_allowed_values) == 0 || length(setintersection(var.enforce_custom_format.enforce_no_allowed_values, values(var.tags))) == 0
      error_message = "The tags map values must not contain any of these values: ${join(", ", var.enforce_custom_format.enforce_no_allowed_values)}."
    }

    precondition {
      condition     = length(var.enforce_custom_format.enforce_reserved_tags) == 0 || length(setintersection(var.enforce_custom_format.enforce_reserved_tags, keys(var.tags))) == 0
      error_message = "The tags map keys must not contain any of these values: ${join(", ", var.enforce_custom_format.enforce_reserved_tags)}."
    }
  }
}
