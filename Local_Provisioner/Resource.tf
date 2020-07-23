resource "aws_instance" "Instance1"{
    availability_zone=var.az["${var.workspace}"]
    ami=var.ami["${var.region}"]
    instance_type=var.instance
    key_name="AnsibleKeyPair"
    security_groups=[aws_security_group.Port80and22.name]

    tags={
        Name="First_Instance"
    }

    provisioner "local-exec"{
        command="echo ${aws_instance.Instance1.public_ip} >> public_ip.txt "
    }

    provisioner "remote-exec"{
        inline=[
            "sudo amazon-linux-extras enable nginx1.12",
            "sudo yum -y install nginx",
            "sudo systemctl start nginx",
        ]
    }

    connection {
        type="ssh"
        host=aws_instance.Instance1.public_ip
        user="ec2-user"
        password=""
        # place the .pem file in the folder where you have placed your terraform scripts 
        # C:\Users\Niharika\Documents\Terraform_Scripts\Local_Provisioner
        private_key=file("./AnsibleKeyPair.pem")

    }
}