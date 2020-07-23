terraform {
    backend "s3"{
        bucket="terraform-tf-state-bucket-name"
        key="Map_Instance_Launch/terraform.tfstate"
        region="us-east-1"
        # removed access key and secret key for security reasons
        access_key=""
        secret_key=""
    }
}