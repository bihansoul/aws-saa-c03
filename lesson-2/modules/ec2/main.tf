
variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

resource "tls_private_key" "nguyendt15_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "nguyendt15_key_pair" {
  key_name   = "nguyendt15-key-pair"
  public_key = tls_private_key.nguyendt15_private_key.public_key_openssh
}

resource "aws_security_group" "nguyendt15_security_group" {
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nguyendt15_ec2" {
  ami           = "ami-0361bbf2b99f46c1d"
  instance_type = "t2.micro"
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.nguyendt15_security_group.id]
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<html><body><h1>Hello, World!</h1></body></html>" > /var/www/html/index.html
              EOF
  tags = {
    Name = "nguyendt15-ec2"
  }
}