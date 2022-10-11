<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1, < 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_uuid.enforce_not_allowed_in_tags](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [random_uuid.enforced_rules_basic](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [random_uuid.enforced_rules_custom](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [random_uuid.enforced_rules_format](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [random_uuid.enforced_tags](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enforce_custom_format"></a> [enforce\_custom\_format](#input\_enforce\_custom\_format) | A map of rules to enforce on all resources. When OMD data, and tags is required, there are custom rules that are normally :<br>enforced, for cost-allocation, and finops purposes. The list of allowed rules are described as follows:<br>- enforce\_prefix\_in\_keys: Ensures that all tag keys start with a specific prefix. Default is "".<br>- enforce\_suffix\_in\_keys: Ensures that all tag keys end with a specific suffix. Default is "".<br>- enforce\_max\_number\_of\_tags: Ensures that all resources don't have more than a specific number of tags. Default is 0.<br>- enforce\_no\_allowed\_values: Ensures that all resources don't have any of the values specified in this list. Default is [].<br>- enforce\_reserved\_tags: Ensures that all resources don't have any of the tags specified in this list. Default is []. | <pre>object({<br>    enforce_prefix_in_keys     = string<br>    enforce_suffix_in_keys     = string<br>    enforce_max_number_of_tags = number<br>    enforce_no_allowed_values  = list(string)<br>    enforce_reserved_tags      = list(string)<br>  })</pre> | <pre>{<br>  "enforce_max_number_of_tags": 0,<br>  "enforce_no_allowed_values": [],<br>  "enforce_prefix_in_keys": "",<br>  "enforce_reserved_tags": [],<br>  "enforce_suffix_in_keys": ""<br>}</pre> | no |
| <a name="input_enforce_no_allowed_in_tags"></a> [enforce\_no\_allowed\_in\_tags](#input\_enforce\_no\_allowed\_in\_tags) | A map of rules to enforce on all resources.  This is useful for tagging resources with a common set of rules. These set of rules<br>aims to provide a set a pre-defined validations, that catch common mistakes when tagging resources. The list of allowed rules<br>are described as follows:<br>- enforce\_no\_spaces\_in\_values: Ensures that all tag values don't contain spaces. Default is false.<br>- enforce\_no\_spaces\_in\_keys: Ensures that all tag keys don't contain spaces. Default is false.<br>- enforce\_no\_special\_characters\_in\_values: Ensures that all tag values don't contain special characters. Default is false.<br>- enforce\_no\_special\_characters\_in\_values\_except: Ensures that all tag values don't contain special characters, except for the ones specified in this list. Default is [].<br>- enforce\_no\_special\_characters\_in\_keys: Ensures that all tag keys don't contain special characters. Default is false.<br>- enforce\_no\_empty\_values: Ensures that all tag values don't contain empty values. Default is false.<br>- enforce\_no\_empty\_keys: Ensures that all tag keys don't contain empty keys. Default is false. | <pre>object({<br>    enforce_no_spaces_in_values                    = bool<br>    enforce_no_spaces_in_keys                      = bool<br>    enforce_no_special_characters_in_values        = bool<br>    enforce_no_special_characters_in_keys          = bool<br>    enforce_no_special_characters_in_values_except = list(string)<br>    enforce_no_empty_values                        = bool<br>    enforce_no_empty_keys                          = bool<br>  })</pre> | <pre>{<br>  "enforce_no_empty_keys": false,<br>  "enforce_no_empty_values": false,<br>  "enforce_no_spaces_in_keys": false,<br>  "enforce_no_spaces_in_values": false,<br>  "enforce_no_special_characters_in_keys": false,<br>  "enforce_no_special_characters_in_values": false,<br>  "enforce_no_special_characters_in_values_except": []<br>}</pre> | no |
| <a name="input_enforce_rules_basics"></a> [enforce\_rules\_basics](#input\_enforce\_rules\_basics) | A set of rules to enforce on all tags.  This is useful for enforcing a common set of rules on all tags.<br>with likely validations commonly used for cloud resource tagging, and finOps. | <pre>object({<br>    enforce_all_keys_and_values_are_filled = bool<br>    enforce_no_whitespaces_in_tag_values   = bool<br>  })</pre> | <pre>{<br>  "enforce_all_keys_and_values_are_filled": false,<br>  "enforce_no_whitespaces_in_tag_values": false<br>}</pre> | no |
| <a name="input_enforced_rules_format"></a> [enforced\_rules\_format](#input\_enforced\_rules\_format) | A map of rules to enforce on all resources.  This is useful for tagging resources with a common set of rules.<br>These enforced rules act upon the var.enforced\_tags map, and aims to enforce high-level/general set of<br>rules that applies either for tag keys, or their respective values.<br>The rules currently enforced are:<br>- enforce\_lowercase\_tag\_keys: Ensures that all tag keys are lowercase. Default is false.<br>- enforce\_uppercase\_tag\_keys: Ensures that all tag keys are uppercase. Default is false.<br>- enforce\_lowercase\_tag\_values: Ensures that all tag values are lowercase. Default is false.<br>- enforce\_uppercase\_tag\_values: Ensures that all tag values are uppercase. Default is false.<br>- enforce\_camel\_case\_in\_values: Ensures that all tag values are camel case. Default is false.<br>- enforce\_camel\_case\_in\_keys: Ensures that all tag keys are camel case. Default is false.<br>- enforce\_snake\_case\_in\_keys: Ensures that all tag keys are snake case. Default is false.<br>- enforce\_snake\_case\_in\_values: Ensures that all tag values are snake case. Default is false.<br>- enforce\_kebab\_case\_in\_keys: Ensures that all tag keys are kebab case. Default is false.<br>- enforce\_kebab\_case\_in\_values: Ensures that all tag values are kebab case. Default is false.<br>- enforce\_no\_escaped\_characters: Ensures that all tag keys and values don't contain escaped characters. Default is true. | <pre>object({<br>    enforce_lowercase_tag_keys    = bool<br>    enforce_uppercase_tag_keys    = bool<br>    enforce_lowercase_tag_values  = bool<br>    enforce_uppercase_tag_values  = bool<br>    enforce_camel_case_in_values  = bool<br>    enforce_camel_case_in_keys    = bool<br>    enforce_snake_case_in_keys    = bool<br>    enforce_snake_case_in_values  = bool<br>    enforce_kebab_case_in_keys    = bool<br>    enforce_kebab_case_in_values  = bool<br>    enforce_no_escaped_characters = bool<br>  })</pre> | <pre>{<br>  "enforce_camel_case_in_keys": false,<br>  "enforce_camel_case_in_values": false,<br>  "enforce_kebab_case_in_keys": false,<br>  "enforce_kebab_case_in_values": false,<br>  "enforce_lowercase_tag_keys": false,<br>  "enforce_lowercase_tag_values": false,<br>  "enforce_no_escaped_characters": true,<br>  "enforce_snake_case_in_keys": false,<br>  "enforce_snake_case_in_values": false,<br>  "enforce_uppercase_tag_keys": false,<br>  "enforce_uppercase_tag_values": false<br>}</pre> | no |
| <a name="input_enforced_tags"></a> [enforced\_tags](#input\_enforced\_tags) | A map of tags to enforce on all resources.  This is useful for tagging resources with a common set of tags.<br>If this set of tags aren't set, this module will trigger an error, in order to be managed<br>by the upstream module that sets these tags. | `map(string)` | `{}` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether to enable this module, its validations and eventual resources, or not. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Set of tags passed by the caller module. This set of tags will be validated against the set of rules described by<br>this module. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_result"></a> [result](#output\_result) | The result of the tag enforcer, their rules, and validations. Possible values and their meaning are:<br>  - "PASS" - All resources have the required tags, and have passedd all validations.<br>  - "FAIL" - One or more resources are missing required tags, or have failed one or more validations. |
| <a name="output_summary"></a> [summary](#output\_summary) | This output is used to show the tags and enforced tags |
<!-- END_TF_DOCS -->
