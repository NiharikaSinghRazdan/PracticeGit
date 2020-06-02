resource "aws_instance" "InstanceNo" {
  availability_zone = var.a-zone
  ami               = var.ami
  instance_type     = var.instance
  key_name          = "AnsibleKeyPair"

  tags = {
    Name = "Instances"
  }
}

