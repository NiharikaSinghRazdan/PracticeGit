output "public_ip" {
  value = [aws_instance.InstanceNo.public_ip]
}