# This provider configuration comes from https://docs.localstack.cloud/integrations/terraform/#request-management
# and enables you to run terraform locally against a simulated aws environment using saltsack.
#
# This should definitely change when running against a real environment. 
# * The access keys shouldn't be used.
# * The s3_use_path_style, skip_credentials_validation, skip_metadata_api_check and skip_requesting_account_id 
#   values should be removed.
# * The endpoints should be the aws ones (will be enough removing the endpoints block).

provider "aws" {

  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"


  # only required for non virtual hosted-style endpoint use case.
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs#s3_force_path_style
  s3_use_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true


    endpoints {
        s3             = "http://s3.localhost.localstack.cloud:4566"
    }
}