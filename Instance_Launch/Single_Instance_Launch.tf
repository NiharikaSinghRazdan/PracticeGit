resource "aws_instance" "EC2-Instance" {
    availability_zone = var.az
    instance_type = var.instance_type
    ami= var.ami
    key_name=var.key
    vpc_security_group_ids=[aws_security_group.Port80and22.id]

tags={
    Name="EC2_Instance"
     }
user_data = <<-EOF
 #!/bin/bash
    sudo yum update
    sudo yum install httpd -y
    sudo service httpd start
    sudo chkconfig httpd on
    /bin/echo "Hello from " >/var/www/html/index.html
    instance_ip=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
    echo $instance_ip >>/var/www/html/index.html
 EOF
}
