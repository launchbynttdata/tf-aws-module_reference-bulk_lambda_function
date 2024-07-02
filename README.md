# tf-aws-module_reference-bulk_lambda_function

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module provides ability to create multiple lambda functions.

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
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
| <a name="module_lambda_function"></a> [lambda\_function](#module\_lambda\_function) | terraform.registry.launch.nttdata.com/module_primitive/lambda_function/aws | ~> 1.0 |
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bulk_lambda_functions"></a> [bulk\_lambda\_functions](#input\_bulk\_lambda\_functions) | Map of lambda functions to create. | <pre>map(object({<br>    name                    = string<br>    description             = optional(string, "")<br>    handler                 = optional(string, "index.lambda_handler")<br>    runtime                 = optional(string, "python3.9")<br>    architectures           = optional(list(string), ["x86_64"])<br>    publish                 = optional(bool, true)<br>    ephemeral_storage_size  = optional(number, 512)<br>    environment_variables   = optional(map(string), {})<br>    memory_size             = optional(number, 128)<br>    timeout                 = optional(number, 3)<br>    create_package          = optional(bool, false)<br>    source_path             = optional(string)<br>    zip_file_path           = optional(string)<br>    store_on_s3             = optional(bool, false)<br>    s3_existing_package     = optional(map(string))<br>    s3_bucket               = optional(string)<br>    s3_prefix               = optional(string, "builds")<br>    layers                  = optional(list(string))<br>    hash_extra              = optional(string)<br>    ignore_source_code_hash = optional(bool, false)<br>    authorization_type      = optional(string, "NONE")<br>    cors = optional(object({<br>      allow_credentials = optional(bool, false)<br>      allow_headers     = optional(list(string), null)<br>      allow_methods     = optional(list(string), null)<br>      allow_origins     = optional(list(string), null)<br>      expose_headers    = optional(list(string), null)<br>      max_age           = optional(number, 0)<br>    }), {})<br>    create_lambda_function_url         = optional(bool, true)<br>    invoke_mode                        = optional(string, "BUFFERED")<br>    attach_policy_statements           = optional(bool, false)<br>    policy_statements                  = optional(map(string), {})<br>    attach_policy                      = optional(bool, false)<br>    policy                             = optional(string)<br>    attach_policies                    = optional(bool, false)<br>    policies                           = optional(list(string), [])<br>    attach_policy_json                 = optional(bool, false)<br>    policy_json                        = optional(string)<br>    attach_policy_jsons                = optional(bool, false)<br>    policy_jsons                       = optional(list(string), [])<br>    attach_dead_letter_policy          = optional(bool, false)<br>    dead_letter_target_arn             = optional(string)<br>    attach_network_policy              = optional(bool, false)<br>    attach_async_event_policy          = optional(bool, false)<br>    attach_tracing_policy              = optional(bool, false)<br>    assume_role_policy_statements      = optional(map(string), {})<br>    trusted_entities                   = optional(list(string), [])<br>    attach_cloudwatch_logs_policy      = optional(bool, true)<br>    attach_create_log_group_permission = optional(bool, true)<br>    cloudwatch_logs_kms_key_id         = optional(string)<br>    cloudwatch_logs_log_group_class    = optional(string, "STANDARD")<br>    cloudwatch_logs_retention_in_days  = optional(number, 30)<br>    cloudwatch_logs_skip_destroy       = optional(bool, false)<br>    cloudwatch_logs_tags               = optional(map(string))<br>    tracing_mode                       = optional(string, "PassThrough")<br>    vpc_security_group_ids             = optional(list(string))<br>    vpc_subnet_ids                     = optional(list(string))<br>    lambda_at_edge                     = optional(bool, false)<br>    lambda_at_edge_logs_all_regions    = optional(bool, true)<br>    tags                               = optional(map(string))<br>    create                             = optional(bool, true)<br>  }))</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"dev"` | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region in which the infra needs to be provisioned | `string` | `"us-east-2"` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
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
