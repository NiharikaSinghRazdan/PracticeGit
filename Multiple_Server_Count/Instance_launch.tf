#With below line, you will get to know how many availability zones are available in given region
data "aws_availability_zones" "available" {}

resource "aws_instance" "first_instance"{
    ami=var.ami
    instance_type=var.instance_type
    count=length(data.aws_availability_zones.available.names)
    key_name="AnsibleKeyPair"
    availability_zone=data.aws_availability_zones.available.names[count.index]

    tags ={
        Name="InstanceCreated-${count.index}"
    }
}