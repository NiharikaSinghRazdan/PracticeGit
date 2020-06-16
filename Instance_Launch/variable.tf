variable "region"{
    default="us-east-1"
    }
variable "profile"{
    default="demop"
}

variable "az"{
    default="us-east-1a"
}

variable "instance_type"{
    default= "t2.micro"
}

variable "ami"{
    default="ami-09d95fab7fff3776c"
}

variable "mysystem"{
    default="0.0.0.0/0"
}

variable "key"{
    default="AnsibleKeyPair"
}