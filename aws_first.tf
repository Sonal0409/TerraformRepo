

provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAQN2UCWBUFXHCIUWU"
  secret_key = "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"
}

resource "aws_instance" "web" {
  ami           = "ami-0800fc0fa715fdcfe"
  instance_type = "t3.micro"
}


resource "aws_eip" "lb" {
  vpc      = true
}

output "eip" {
value = aws_eip.lb.public_ip
}
resource "aws_s3_bucket" "sonals3" {
  bucket = "my-code-attribute-demo-s3"
}

output "s3bucket" {
value = aws_s3_bucket.sonals3.bucket_domain_name
}
