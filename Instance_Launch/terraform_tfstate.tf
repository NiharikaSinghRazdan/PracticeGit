terraform {
    backend "s3" {
        bucket="terraform-tf-state-bucket-name"
        key="Instance_Launch/terraform.tfstate"
        region="us-east-1"
#removed credentials for safety reasons
        access_key=""
        secret_key=""
    }
}