#configure the AWS provider
provider "aws"{
       region  = var.region
       profile = var.profile
}

#Configure the VPC
resource "aws_vpc" "DevopsVPC"{
        cidr_block=var.VPCcidrBlock
              
        tags = {
        Name = "DevopsVPC"
               }
}

#Configure first public subnet
resource "aws_subnet" "Public_Subnet1" {
         cidr_block        =var.PublicSubCidr1
         vpc_id            = aws_vpc.DevopsVPC.id
         availability_zone =var.AZ1
         
         tags = {
         Name ="Public_Subnet1"
                }
}

#Configure second public subnet
resource "aws_subnet" "Public_Subnet2"{
          cidr_block        =var.PublicSubCidr2
          vpc_id            = aws_vpc.DevopsVPC.id
          availability_zone =var.AZ3

          tags = {
          Name ="Public_Subnet2"
                 }
}

#Configure first Private Subnet
resource "aws_subnet" "Private_Subnet1"{
          cidr_block        =var.PrivateSubCidr1
          vpc_id            = aws_vpc.DevopsVPC.id
          availability_zone =var.AZ2

          tags = {
          Name ="Private_Subnet1"
                 }
}

#Configure second private subnet
resource "aws_subnet" "Private_Subnet2"{
          cidr_block        =var.PrivateSubCidr2
          vpc_id            = aws_vpc.DevopsVPC.id
          availability_zone =var.AZ2

          tags = {
          Name ="Private_Subnet2"
                 }
}

#Configure Internet Gateway
resource "aws_internet_gateway" "DevopsIG"{
          vpc_id=aws_vpc.DevopsVPC.id

          tags = {
          Name ="DevopsIG"
                 }
}



#Configure NAT Gateway
#resource "aws_nat_gateway" "DevopsNAT"{
#         allocation_id="aws_eip.NAT.id"
#         subnet_id="aws_subnet.Public_Subnet1.id"
#
#         tags = {
#         Name = "DevopsNAT"
#                }
#}


#Configure Public route table
resource "aws_route_table" "DevopsPublicRoute"{
          vpc_id=aws_vpc.DevopsVPC.id

          route {
          cidr_block="0.0.0.0/0"
          gateway_id=aws_internet_gateway.DevopsIG.id
                 }
 
          tags = {
          Name ="DevopsPublicRoute"
                 }
}

#Configure Private route table
#resource "aws_route_table" "DevopsPrivateRoute"{
#         vpc_id=aws_vpc.DevopsVPC.id
#
#         route {
#         cidr_block="0.0.0.0/0"
#         natgateway_id=aws_nat_gateway.DevopsNAT.id
#                }
# 
#         tags = {
#         Name ="DevopsPrivateRoute"
#                }
#}

#Associate Public subnets to Public Route
resource "aws_route_table_association" "Public"{
          subnet_id      =aws_subnet.Public_Subnet1.id
          route_table_id = aws_route_table.DevopsPublicRoute.id
}

#Associate Public subnets to Public Route
resource "aws_route_table_association" "Public2"{
          subnet_id      =aws_subnet.Public_Subnet2.id
          route_table_id = aws_route_table.DevopsPublicRoute.id
}

#Associate Internet Gateway to Public Route table
resource "aws_route_table_association" "Public1" {
          gateway_id     = aws_internet_gateway.DevopsIG.id
          route_table_id = aws_route_table.DevopsPublicRoute.id
}

#Associate Private subnets to Private Route
#resource "aws_route_table_association" "Private" {
#          subnet_id      =aws_subnet.Private_Subnet1.id
#          route_table_id = aws_route_table.DevopsPrivateRoute.id
#}

#Associate Private subnets to Private Route
#resource "aws_route_table_association" "Private2" {
#          subnet_id      = aws_subnet.Private_Subnet2.id
#          route_table_id = aws_route_table.DevopsPrivateRoute.id
#}
        
#Associate Security Group to VPC
resource "aws_security_group" "VPCSG"{
#          name         = "DevOps VPC Security Group"
          description = "Allow port 22, 80 and 443"
          vpc_id       = aws_vpc.DevopsVPC.id

          ingress {
          description  = "Port 22"
          from_port    = 22
          to_port      = 22
          protocol     = "tcp"
          cidr_blocks   =["0.0.0.0/0"]
                   }
          
           ingress {
          description  = "Port 80"
          from_port    = 80
          to_port      = 80
          protocol     = "tcp"
          cidr_blocks   =["0.0.0.0/0"]
                   }


          ingress {
          description  = "Port 443"
          from_port    = 443
          to_port      = 443
          protocol     = "tcp"
          cidr_blocks   =["0.0.0.0/0"]
                   }

          egress {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
                 }

          tags = {
          Name = "VPCSG"
                 }
}

#Associate Security Group to VPC
#resource "aws_security_group" "VPCSG22"{
#          name         = "DevOps VPC Security Group2"
#          description = "Allow port 22 only"
#          vpc_id       = aws_vpc.DevopsVPC.id
#
#          ingress {
#          description  = "Port 22"
#          from_port    = 22
#          to_port      = 22
#          protocol     = "tcp"
#          cidr_blocks  =["0.0.0.0/0"]
#                   }
#
#          egress {
#          from_port   = 0
#          to_port     = 0
#          protocol    = "-1"
#          cidr_blocks = ["0.0.0.0/0"]
#                 }
#
#          tags = {
#          Name = "VPCSG22"
#                 }
#}

resource "aws_instance" "PublicInstance1"{
          ami           = var.AMI1
          instance_type = "t2.micro"
          availability_zone = var.AZ1
#          vpc_id            = aws_vpc.DevopsVPC.id
          subnet_id         = aws_subnet.Public_Subnet1.id
          vpc_security_group_ids    = [aws_security_group.VPCSG.id]
          
          tags = {
          Name = "Public_Instance1"
                 }
}

resource "aws_instance" "PrivateInstance1"{
          ami           = var.AMI1
          instance_type = "t2.micro"
          availability_zone = var.AZ2
#          vpc_id            = aws_vpc.DevopsVPC.id
          subnet_id         = aws_subnet.Private_Subnet1.id
          vpc_security_group_ids    = [aws_security_group.VPCSG.id]
          
          tags = {
          Name = "Private_Instance1"
                 }
}

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
data "aws_ami" "DevOpsAMI" {
     most_recent = true
     owners = ["593491129385"]

     filter {
     name = "name"
     values = ["DevOpsAMI"]
            }
    
      filter {
      name   = "virtualization-type"
      values = ["hvm"]
             }

}  

# Get the VPC id of the launched DevOps VPC"
data "aws_vpc" "DevopsVPC"{
      filter {
        name = "tag:Name"
        values = ["DevopsVPC"]
             }
}

# Get the security group id created in launched VPC
#data "aws_security_group" "DevOpsSG"{
#      filter {
#        name = "Name"
#        values = ["VPCSG"]
#             }
#}

# Create Launch Configuration from this AMI
resource "aws_launch_configuration" "DevOpsLaunch" {
         image_id = data.aws_ami.DevOpsAMI.id
         instance_type = "t2.micro"
         security_groups= [aws_security_group.VPCSG.id]
}

#Create AutoScaling group 
resource "aws_autoscaling_group" "DevOpsScaling" {
          name = "DevOpsScaling"
          availability_zones = [var.AZ2]
          desired_capacity = 1
          max_size = 1
          min_size = 1
          launch_configuration = aws_launch_configuration.DevOpsLaunch.name
          vpc_zone_identifier = [var.AZ2]
}

#Create Load Balancer in Public Subnet
resource "aws_lb" "DevOpsLB" {
          name = "DevOpsLB"
          internal = false
          load_balancer_type ="application"
          security_groups =[aws_security_group.VPCSG.id]
          subnets = [aws_subnet.Public_Subnet1.id, aws_subnet.Public_Subnet2.id]
}

#Create S3 endpoint in Private subnet
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.DevopsVPC.id
  service_name = "com.amazonaws.us-east-1.s3"
}