variable "region"{
    default="us-east-1"
    description="Region where you are creating the instances"
}

variable "profile"{
    default="demo"
    description="To execute your terraform code you need accesskey and id and stored in profile"
}

variable "ami"{
    default="ami-09d95fab7fff3776c"
}

variable "instance_type"{
    default="t2.micro"
}
