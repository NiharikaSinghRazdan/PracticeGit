#for_each only supports sets and maps when used on a resource so we will convert it into set.
resource "aws_instance" "launched_instances"{
    instance_type=var.instance
    ami=var.ami
    key_name="AnsibleKeyPair"
    for_each=toset(var.az)
    availability_zone=each.value

    tags={
        Name="Instance"
    }
}