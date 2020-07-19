variable "profile"{
    default="demo"
}

variable "region"{
    default="us-east-1"
}

variable "ami"{
    default="ami-0e9089763828757e1"
}

variable "instance"{
    type=string
    description="if it is t2.micro then launch 1 else launch 2 instances"
}

variable "az"{
    default="us-east-1a"
}