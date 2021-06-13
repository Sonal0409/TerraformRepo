

provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAQN2UCWBUFdfggfXHCIUWU"
  secret_key = "nfd5eLVrnmUXdgfgdgwCnbz59gD8yIayz3XMmZ1XACXRkv"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0800fc0fa715fdcfe"
  instance_type = "t3.micro"
}


resource "aws_eip" "lb1" {
  vpc      = true
}

output "eip" {
value = aws_eip.lb1.public_ip
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.myec2.id
  allocation_id = aws_eip.lb1.id
}
