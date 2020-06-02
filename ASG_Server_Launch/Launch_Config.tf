resource "aws_launch_configuration" "LaunchConfig" {
  image_id        = var.ami
  instance_type   = var.instance
  security_groups = [aws_security_group.Port80and22.id]
}