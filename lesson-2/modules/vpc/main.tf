#Tao vpc
resource "aws_vpc" "nguyendt15_vpc" {
  cidr_block = "10.0.0.0/16" 

  tags = {
    Name = "nguyendt15-vpc"
  }
}

# Tao 1 public subnet
resource "aws_subnet" "nguyendt15_vpc_subnet" {
  vpc_id                  = aws_vpc.nguyendt15_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "nguyendt15-vpc-subnet"
  }
}

# Tao gateway
resource "aws_internet_gateway" "nguyendt15_internet_gateway" {
  vpc_id = aws_vpc.nguyendt15_vpc.id

  tags = {
    Name = "nguyendt15-gw"
  }
}

# Tao route table va gan vao VPC
resource "aws_route_table" "nguyendt15_route_table" {
  vpc_id = aws_vpc.nguyendt15_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nguyendt15_internet_gateway.id
  }

  tags = {
    Name = "nguyendt15-route-table"
  }
}

resource "aws_route_table_association" "nguyendt15_route_table_association" {
  subnet_id      = aws_subnet.nguyendt15_vpc_subnet.id
  route_table_id = aws_route_table.nguyendt15_route_table.id
}

output "vpc_id" {
  value = aws_vpc.nguyendt15_vpc.id
}

output "subnet_id" {
  value = aws_subnet.nguyendt15_vpc_subnet.id
}
