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
  source   = "git::https://github.com/launchbynttdata/tf-aws-module_primitive-lambda_function.git?ref=1.0.1"
  for_each = var.bulk_lambda_functions

  name                               = each.value.name
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
  tags                               = each.value.tags
  create                             = each.value.create
}
