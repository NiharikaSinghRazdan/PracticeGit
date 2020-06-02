# Create multiple EC2 instances using count. Name those instances using index of this count.
resource "aws_instance" "Instance-Create"{
    count=3
    instance_type=var.instance
    ami=var.ami
    availability_zone=var.a-zone
    key_name="AnsibleKeyPair"
# use interpolation to name the created instances using count.index   
    tags ={
        Name="Instance-Create-${count.index}"
    }
}