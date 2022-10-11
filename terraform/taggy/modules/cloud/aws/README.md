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
| [random_uuid.enforce_acm_certificate_validations](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [random_uuid.enforce_basic_aws](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [random_uuid.enforce_length_validation](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enforce_acm_certificate_limit"></a> [enforce\_acm\_certificate\_limit](#input\_enforce\_acm\_certificate\_limit) | Based on the official AWS documentation, there's a hard limit for ACM certificate tags. For<br>more information, please refer to: https://docs.aws.amazon.com/acm/latest/userguide/tags-restrictions.html | `bool` | `false` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether to enable this module, its validations and eventual resources, or not. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | An arbitrary map of tags (key-value pairs) to assign to the resource.<br>These set of modules are validated against known, and documented constraints in AWS. For more<br>information, see the AWS documentation about tags: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_result"></a> [result](#output\_result) | The result of the tag validation, their rules, and validations. Possible values and their meaning are:<br>  - "PASS" - All resources have the required tags, and have passedd all validations.<br>  - "FAIL" - One or more resources are missing required tags, or have failed one or more validations. |
| <a name="output_summary"></a> [summary](#output\_summary) | The results after the AWS tags validation has been performed. About the AWS limits, the<br>AWS limits applied for AWS tags validations, and restrictions. For more<br>information, see the AWS documentation about tag restrictions: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#tag-restrictions |
<!-- END_TF_DOCS -->