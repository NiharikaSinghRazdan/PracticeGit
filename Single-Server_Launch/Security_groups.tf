resource "aws_security_group" "Port80and22"{
    ingress{
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_blocks=[var.mysystem]

    }
    
    ingress{
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_blocks=[var.mysystem]
    }
}