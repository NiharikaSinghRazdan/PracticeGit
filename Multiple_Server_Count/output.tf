output "availability_zones"{
    value=[data.aws_availability_zones.available.names]
}

output "public-ip"{
    value=[aws_instance.first_instance.*.public_ip]
}