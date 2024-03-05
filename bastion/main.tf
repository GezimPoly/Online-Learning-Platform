resource "aws_instance" "web_server" {
  ami           = "ami-0f8ca728008ff5af4"
  instance_type = "t2.micro"
  key_name      = "terraform-key"
  subnet_id     = aws_subnet.public_subnet-1a.id

  vpc_security_group_ids = [
    aws_security_group.ssh_access.id
  ]
}
resource "aws_security_group" "ssh_access" {
  name_prefix = "ssh_access"
  vpc_id      = aws_vpc.main.id



  ingress {
    description = "Allow SSH from my computer"

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow all traffic through HTTP"

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_eip" "eip" {
  instance = aws_instance.web_server.id

  tags = {
    Name = "Gtest-eip"
  }
}
resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Security group for databases"
  vpc_id      = aws_vpc.main.id


  ingress {
    description     = "Allow MySQL traffic from only the web sg"
    from_port       = "3306"
    to_port         = "3306"
    protocol        = "tcp"
    security_groups = [aws_security_group.ssh_access.id]
  }

  tags = {
    Name = "db_sg"
  }
}
