# Create AMI of your launched instance and create auto-scaling group with load balancer

# Get the Instance id of running instance
data "aws_instance" "Public_Instance1" {
      filter {
         name = "tag:Name"
         values = ["Public_Instance1"]
 }
}
  
# Create an AMI of the launched instance
resource "aws_ami_from_instance" "DevOpsAMI"{
          name = "DevOpsAMI"
          source_instance_id = data.aws_instance.Public_Instance1.id
}

# Get the image id of your created image
#data "aws_ami" "DevOps_AMI" {
#     most_recent = true
#     owners = ["593491129385"]

#     filter {
#     name = "name"
#     values = ["DevOpsAMI"]
#            }

#    filter {
#    name = "root_device_type"
#    values = ["ebs"]
#           }
#}
#output "Created_AMI" {
# value = data.aws_ami.DevOps_AMI.id
#}  


# Get the VPC id of the launched DevOps VPC"
data "aws_vpc" "DevopsVPC"{
      filter {
        name = "tag:Name"
        values = ["DevopsVPC"]
             }
}

# Get the private subnet ids of the VPC
data "aws_subnet_ids" "Private_Subnet1" {
      vpc_id = data.aws_vpc.DevopsVPC.id

       filter {
         name = "tag:Name"
         values = ["Private_Subnet1"]
    
  }
}

# Get the security group id created in launched VPC
data "aws_security_group" "DevOpsSG"{
      filter {
        name = "tag:Name"
        values = ["VPCSG"]
             }
}

# Create Launch Configuration from this AMI
resource "aws_launch_configuration" "DevOpsLaunch" {
         image_id = aws_ami_from_instance.DevOpsAMI.id
         instance_type = "t2.micro"
         security_groups= [data.aws_security_group.DevOpsSG.id]
}

#Create AutoScaling group 
resource "aws_autoscaling_group" "DevOpsScaling" {
          name = "DevOpsScaling"
          availability_zones = [var.AZ2]
          desired_capacity = 1
          max_size = 1
          min_size = 1
          launch_configuration = aws_launch_configuration.DevOpsLaunch.name
          vpc_zone_identifier = [data.aws_subnet_ids.Private_Subnet1.id]
}



