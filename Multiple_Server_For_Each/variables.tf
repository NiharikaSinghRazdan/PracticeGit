variable "region"{
    default="us-east-1"
}

variable "profile"{
    default="demo"
}

variable "az"{
    type=list(string)
    default=["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "instance"{
    default="t2.micro"
}

variable "ami"{
    default="ami-09d95fab7fff3776c"
}