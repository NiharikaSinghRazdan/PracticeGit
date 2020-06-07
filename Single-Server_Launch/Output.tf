output "public-ip"{
    value=[aws_instance.FirstInstance.public_ip]
}