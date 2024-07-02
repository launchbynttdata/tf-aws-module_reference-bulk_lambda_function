// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "lambda_function" {
  source   = "terraform.registry.launch.nttdata.com/module_primitive/lambda_function/aws"
  version  = "~> 1.0"
  for_each = var.bulk_lambda_functions

  name                               = "${module.resource_names["function"].standard}_${each.value.name}"
  description                        = each.value.description
  handler                            = each.value.handler
  runtime                            = each.value.runtime
  architectures                      = each.value.architectures
  publish                            = each.value.publish
  ephemeral_storage_size             = each.value.ephemeral_storage_size
  environment_variables              = each.value.environment_variables
  memory_size                        = each.value.memory_size
  timeout                            = each.value.timeout
  create_package                     = each.value.create_package
  source_path                        = each.value.source_path
  zip_file_path                      = each.value.zip_file_path
  store_on_s3                        = each.value.store_on_s3
  s3_existing_package                = each.value.s3_existing_package
  s3_bucket                          = each.value.s3_bucket
  s3_prefix                          = each.value.s3_prefix
  layers                             = each.value.layers
  hash_extra                         = each.value.hash_extra
  ignore_source_code_hash            = each.value.ignore_source_code_hash
  authorization_type                 = each.value.authorization_type
  cors                               = each.value.cors
  create_lambda_function_url         = each.value.create_lambda_function_url
  invoke_mode                        = each.value.invoke_mode
  attach_policy_statements           = each.value.attach_policy_statements
  policy_statements                  = each.value.policy_statements
  attach_policy                      = each.value.attach_policy
  policy                             = each.value.policy
  attach_policies                    = each.value.attach_policies
  policies                           = each.value.policies
  policy_json                        = each.value.policy_json
  attach_policy_json                 = each.value.attach_policy_json
  policy_jsons                       = each.value.policy_jsons
  attach_policy_jsons                = each.value.attach_policy_jsons
  attach_dead_letter_policy          = each.value.attach_dead_letter_policy
  dead_letter_target_arn             = each.value.dead_letter_target_arn
  attach_network_policy              = each.value.attach_network_policy
  attach_async_event_policy          = each.value.attach_async_event_policy
  attach_tracing_policy              = each.value.attach_tracing_policy
  assume_role_policy_statements      = each.value.assume_role_policy_statements
  trusted_entities                   = each.value.trusted_entities
  attach_cloudwatch_logs_policy      = each.value.attach_cloudwatch_logs_policy
  attach_create_log_group_permission = each.value.attach_create_log_group_permission
  cloudwatch_logs_kms_key_id         = each.value.cloudwatch_logs_kms_key_id
  cloudwatch_logs_log_group_class    = each.value.cloudwatch_logs_log_group_class
  cloudwatch_logs_retention_in_days  = each.value.cloudwatch_logs_retention_in_days
  cloudwatch_logs_skip_destroy       = each.value.cloudwatch_logs_skip_destroy
  cloudwatch_logs_tags               = each.value.cloudwatch_logs_tags
  tracing_mode                       = each.value.tracing_mode
  vpc_security_group_ids             = each.value.vpc_security_group_ids
  vpc_subnet_ids                     = each.value.vpc_subnet_ids
  lambda_at_edge                     = each.value.lambda_at_edge
  lambda_at_edge_logs_all_regions    = each.value.lambda_at_edge_logs_all_regions
  tags                               = merge(each.value.tags, { resource_name = "${module.resource_names["function"].standard}_${each.value.name}" })
  create                             = each.value.create
}


module "resource_names" {
  source  = "terraform.registry.launch.nttdata.com/module_library/resource_name/launch"
  version = "~> 1.0"

  for_each = var.resource_names_map

  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service

  region              = join("", split("-", var.region))
  class_env           = var.environment
  cloud_resource_type = each.value.name
  instance_env        = var.instance_env
  instance_resource   = var.instance_resource
  maximum_length      = each.value.max_length
}
