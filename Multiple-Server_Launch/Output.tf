output "public-ip"{
    value=[aws_instance.Instance-Create.*.public_ip]
}