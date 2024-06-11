bulk_lambda_functions = {
  "test_lambda_fn-1" = {
    name           = "test_lambda_fn-1"
    create_package = true
    source_path    = "test_lambda_fn-1"
    cors = {
      allow_credentials = true
      allow_origins     = ["*"]
      allow_methods     = ["*"]
      allow_headers     = ["date", "keep-alive"]
      expose_headers    = ["keep-alive", "date"]
      max_age           = 86400
    }
    hash_extra = "." # Seems to resolve a provider error. You can supply whatever value as long as there's a value supplied.
  },
  "test_lambda_fn-2" = {
    name           = "test_lambda_fn-2"
    create_package = true
    source_path    = "test_lambda_fn-2"
    hash_extra     = "." # Seems to resolve a provider error. You can supply whatever value as long as there's a value supplied.
    cors = {
      allow_credentials = true
      allow_origins     = ["*"]
      allow_methods     = ["*"]
      allow_headers     = ["date", "keep-alive"]
      expose_headers    = ["keep-alive", "date"]
      max_age           = 86400
    }
    hash_extra = "." # Seems to resolve a provider error. You can supply whatever value as long as there's a value supplied.
  }
}
environment             = "demo"
instance_env            = 0
region                  = "us-east-1"
instance_resource       = 0
logical_product_family  = "launch"
logical_product_service = "lambda"
resource_names_map = {
  function = {
    name       = "function"
    max_length = 64
  }
}
