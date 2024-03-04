
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-central-1a"
  tags = {
    Name = "GPublic Subnet1a"
  }
}
resource "aws_subnet" "public_subnet-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-central-1b"
  tags = {
    Name = "GPublic Subnet1b"
  }
}
resource "aws_subnet" "private_subnet-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-central-1a"


  tags = {
    Name = "GPrivate Subnet1a"
  }
}
resource "aws_subnet" "private_subnet-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-central-1b"

  tags = {
    Name = "GPrivate Subnet1b"
  }
}



// internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Gigw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Groute-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet-1a.id
  route_table_id = aws_route_table.public.id
}


output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "vpc_id" {
  value = aws_vpc.main.id

}