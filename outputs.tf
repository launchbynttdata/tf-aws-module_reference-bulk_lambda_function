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

output "lambda_function_arns" {
  value = { for k, v in module.lambda_function : k => v.lambda_function_arn }
}

output "lambda_function_names" {
  value = { for k, v in module.lambda_function : k => v.lambda_function_name }
}

output "lambda_cloudwatch_log_group_arns" {
  value = { for k, v in module.lambda_function : k => v.lambda_cloudwatch_log_group_arn }
}

output "lambda_cloudwatch_log_group_names" {
  value = { for k, v in module.lambda_function : k => v.lambda_cloudwatch_log_group_name }
}

output "lambda_function_urls" {
  value = { for k, v in module.lambda_function : k => v.lambda_function_url }
}

output "lambda_role_arns" {
  value = { for k, v in module.lambda_function : k => v.lambda_role_arn }
}

output "lambda_role_names" {
  value = { for k, v in module.lambda_function : k => v.lambda_role_name }
}
