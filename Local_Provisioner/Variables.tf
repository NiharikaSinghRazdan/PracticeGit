variable "region"{
    default="us-east-1"
}

variable "profile"{
    default="demo"
}

variable "az"{
    type=map
    default={
        test1a="us-east-1a"
        test1b="us-east-1b"

    }
}

variable "workspace"{
    default="test1a"
}

variable "instance"{
    default="t2.micro"
}

variable "ami"{
    type=map
    default={
        us-east-1="ami-08f3d892de259504d"
        us-east-2="ami-016b213e65284e9c9"
        us-west-1="ami-01311df3780ebd33e"
    }
}