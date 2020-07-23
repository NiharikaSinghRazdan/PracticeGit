#Profile Variable
variable "profile"{
          default = "demonew"
}

#Variable region
variable "region"{
          default  = "us-east-1"
}

#Variable VPC-name
variable "VPC" {
          default ="DevopsVPC"
}

#Variable VPC CIDR block
variable "VPCcidrBlock"{
          default="10.0.0.0/24"
}

#Variable Public Subnet-1 CIDR block
variable "PublicSubCidr1"{
          default="10.0.0.0/26"
}

#Variable Public Subnet-2 CIDR block
variable "PublicSubCidr2"{
          default="10.0.0.64/26"
}

#Variable Private Subnet-1 CIDR block
variable "PrivateSubCidr1"{
          default="10.0.0.128/26"
}

#Variable Private Subnet-2 CIDR block
variable "PrivateSubCidr2"{
          default="10.0.0.192/26"
}

#Variable availability zone-1
variable "AZ1"{
          default="us-east-1a"
}

#Variable availability zone-2
variable "AZ2"{
          default="us-east-1b"
}

#Variable availability zone-2
variable "AZ3"{
          default="us-east-1c"
}

#Variable ami-id
variable "AMI1"{
          default="ami-085925f297f89fce1"
}

