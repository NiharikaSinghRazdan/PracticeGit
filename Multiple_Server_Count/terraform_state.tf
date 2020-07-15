terraform {
    backend "s3"{
        bucket="terraform-tf-state-bucket-name"
        key="terraform.tfstate"
        region="us-east-1"
# When you want the state file to be stored in S3, you have to provide access_key and secret_key because s3 
# will look for access key and secret key in this loop. It will not be able to check in provider or credentials
# file. Deleted access and secret key because of security concern as I need to upload the code in 
        access_key=""
        secret_key=" "
    }
}