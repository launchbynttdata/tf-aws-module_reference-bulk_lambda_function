# bulk_lambda_functions

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, <= 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bulk_lambda_functions"></a> [bulk\_lambda\_functions](#module\_bulk\_lambda\_functions) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bulk_lambda_functions"></a> [bulk\_lambda\_functions](#input\_bulk\_lambda\_functions) | Map of lambda functions to create. | <pre>map(object({<br>    name                    = string<br>    description             = optional(string, "")<br>    handler                 = optional(string, "index.lambda_handler")<br>    runtime                 = optional(string, "python3.9")<br>    architectures           = optional(list(string), ["x86_64"])<br>    publish                 = optional(bool, true)<br>    ephemeral_storage_size  = optional(number, 512)<br>    environment_variables   = optional(map(string), {})<br>    memory_size             = optional(number, 128)<br>    timeout                 = optional(number, 3)<br>    create_package          = optional(bool, false)<br>    source_path             = optional(string)<br>    zip_file_path           = optional(string)<br>    store_on_s3             = optional(bool, false)<br>    s3_existing_package     = optional(map(string))<br>    s3_bucket               = optional(string)<br>    s3_prefix               = optional(string, "builds")<br>    layers                  = optional(list(string))<br>    hash_extra              = optional(string)<br>    ignore_source_code_hash = optional(bool, false)<br>    authorization_type      = optional(string, "NONE")<br>    cors = optional(object({<br>      allow_credentials = optional(bool, false)<br>      allow_headers     = optional(list(string), null)<br>      allow_methods     = optional(list(string), null)<br>      allow_origins     = optional(list(string), null)<br>      expose_headers    = optional(list(string), null)<br>      max_age           = optional(number, 0)<br>    }), {})<br>    create_lambda_function_url         = optional(bool, true)<br>    invoke_mode                        = optional(string, "BUFFERED")<br>    attach_policy_statements           = optional(bool, false)<br>    policy_statements                  = optional(map(string), {})<br>    attach_policy                      = optional(bool, false)<br>    policy                             = optional(string)<br>    attach_policies                    = optional(bool, false)<br>    policies                           = optional(list(string), [])<br>    attach_policy_json                 = optional(bool, false)<br>    policy_json                        = optional(string)<br>    attach_policy_jsons                = optional(bool, false)<br>    policy_jsons                       = optional(list(string), [])<br>    attach_dead_letter_policy          = optional(bool, false)<br>    dead_letter_target_arn             = optional(string)<br>    attach_network_policy              = optional(bool, false)<br>    attach_async_event_policy          = optional(bool, false)<br>    attach_tracing_policy              = optional(bool, false)<br>    assume_role_policy_statements      = optional(map(string), {})<br>    trusted_entities                   = optional(list(string), [])<br>    attach_cloudwatch_logs_policy      = optional(bool, true)<br>    attach_create_log_group_permission = optional(bool, true)<br>    cloudwatch_logs_kms_key_id         = optional(string)<br>    cloudwatch_logs_log_group_class    = optional(string, "STANDARD")<br>    cloudwatch_logs_retention_in_days  = optional(number, 30)<br>    cloudwatch_logs_skip_destroy       = optional(bool, false)<br>    cloudwatch_logs_tags               = optional(map(string))<br>    tracing_mode                       = optional(string, "PassThrough")<br>    vpc_security_group_ids             = optional(list(string))<br>    vpc_subnet_ids                     = optional(list(string))<br>    lambda_at_edge                     = optional(bool, false)<br>    lambda_at_edge_logs_all_regions    = optional(bool, true)<br>    tags                               = optional(map(string))<br>    create                             = optional(bool, true)<br>  }))</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"dev"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region in which the infra needs to be provisioned | `string` | `"us-east-2"` | no |
| <a name="input_resource_number"></a> [resource\_number](#input\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | n/a | yes |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | n/a | yes |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object(<br>    {<br>      name       = string<br>      max_length = optional(number, 60)<br>    }<br>  ))</pre> | <pre>{<br>  "function": {<br>    "max_length": 60,<br>    "name": "fn"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_arns"></a> [lambda\_function\_arns](#output\_lambda\_function\_arns) | n/a |
| <a name="output_lambda_function_names"></a> [lambda\_function\_names](#output\_lambda\_function\_names) | n/a |
| <a name="output_lambda_cloudwatch_log_group_arns"></a> [lambda\_cloudwatch\_log\_group\_arns](#output\_lambda\_cloudwatch\_log\_group\_arns) | n/a |
| <a name="output_lambda_cloudwatch_log_group_names"></a> [lambda\_cloudwatch\_log\_group\_names](#output\_lambda\_cloudwatch\_log\_group\_names) | n/a |
| <a name="output_lambda_function_urls"></a> [lambda\_function\_urls](#output\_lambda\_function\_urls) | n/a |
| <a name="output_lambda_role_arns"></a> [lambda\_role\_arns](#output\_lambda\_role\_arns) | n/a |
| <a name="output_lambda_role_names"></a> [lambda\_role\_names](#output\_lambda\_role\_names) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
