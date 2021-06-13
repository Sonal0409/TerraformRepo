provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAQN2UCWBUMI23BYFI"
  secret_key = "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"
}

resource "aws_vpc" "edu-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "edureka"
  }
}

resource "aws_internet_gateway" "gw" {
 vpc_id = aws_vpc.edu-vpc.id

 }

resource "aws_route_table" "edu-route-table" {
vpc_id = aws_vpc.edu-vpc.id
route {
cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.gw.id
   }

   route {
     ipv6_cidr_block = "::/0"
     gateway_id      = aws_internet_gateway.gw.id
}

 tags = {
     Name = "edureka"
   }
 }


 resource "aws_subnet" "subnet-1" {
   vpc_id            = aws_vpc.edu-vpc.id
   cidr_block        = "10.0.1.0/24"
   availability_zone = "us-east-1a"

   tags = {
     Name = "edu-subnet"
   }
 }
 resource "aws_route_table_association" "a" {
   subnet_id      = aws_subnet.subnet-1.id
   route_table_id = aws_route_table.edu-route-table.id
 }

 resource "aws_security_group" "allow_web" {
   name        = "allow_web_traffic"
   description = "Allow Web inbound traffic"
     vpc_id      = aws_vpc.edu-vpc.id
ingress {
     description = "HTTPS"
     from_port   = 443
     to_port     = 443
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
}
ingress {
     description = "HTTP"
     from_port   = 80
     to_port     = 80
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
     description = "SSH"
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
     Name = "allow_web"
   }
 }
 resource "aws_network_interface" "web-server-nic" {
   subnet_id       = aws_subnet.subnet-1.id
   private_ips     = ["10.0.1.50"]
    security_groups = [aws_security_group.allow_web.id]


}
resource "aws_eip" "one" {
   vpc                       = true
   network_interface         = aws_network_interface.web-server-nic.id
   associate_with_private_ip = "10.0.1.50"
   depends_on                = [aws_internet_gateway.gw]
 }

