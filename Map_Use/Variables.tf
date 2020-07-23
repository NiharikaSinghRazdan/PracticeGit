variable "region"{
    type=string
    description="Enter the region where you want to launch instance"
}

variable "profile"{
    default="demo"
}

variable "instance"{
    default="t2.micro"
}

variable "az"{
    default="us-east-1a"
}

variable "ami"{
    type=map
    default={
        us-east-1="ami-08f3d892de259504d"
        us-east-2="ami-016b213e65284e9c9"
        us-west-1="ami-01311df3780ebd33e"
    }
}