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

module "bulk_lambda_functions" {
  source = "../.."

  bulk_lambda_functions   = var.bulk_lambda_functions
  environment             = var.environment
  instance_resource       = var.instance_resource
  region                  = var.region
  instance_env            = var.instance_env
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
  resource_names_map      = var.resource_names_map

}
