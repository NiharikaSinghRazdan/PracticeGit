provider "aws"{
 profile= "demop"
 region = "us-east-1"
}

resource "aws_instance" "testinstance"{
 ami = "ami-0323c3dd2da7fb37d"
 instance_type="t2.micro"
}
