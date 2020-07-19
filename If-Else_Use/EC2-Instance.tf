resource "aws_instance" "EC2-Instance"{
    instance_type=var.instance
    ami=var.ami
    key_name="AnsibleKeyPair"
    availability_zone=var.az
    count=(var.instance=="t2.micro" ? 2:1)
    tags ={
        Name="Instance-${count.index}"
    }
}