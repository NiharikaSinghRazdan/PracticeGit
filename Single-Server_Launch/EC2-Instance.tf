provider "aws"{
    profile = var.profile
    region=var.region
}

resource "aws_instance" "FirstInstance"{
    ami= var.ami
    instance_type= var.instance
    key_name="AnsibleKeyPair"
# In document it is mentioned to include security group id but it doesn't work. You have to include name 
# instead of id then only it will work.
    security_groups=[aws_security_group.Port80and22.name]
    tags= {
    Name="FirstInstance"
}
}