# In this code, we have included if else condition on instance type. If the passed type is t2.micro then 
# launch 2 instances else launch 1

resource "aws_instance" "EC2-Instance"{
    instance_type=var.instance
    ami=var.ami
    key_name="AnsibleKeyPair"
    availability_zone=var.az
    # specified if else condition here
    count=(var.instance=="t2.micro" ? 2:1)
    tags ={
        Name="Instance-${count.index}"
    }
}