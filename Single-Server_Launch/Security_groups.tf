resource "aws_security_group" "Port80and22"{
    ingress{
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_blocks=["172.31.0.0/16"]

    }
    
    ingress{
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_blocks=["172.31.0.0/16"]
    }
    egress{
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]

    }
    
    egress{
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }    
    tags = {
        Name = "Port80and22"
        }
}