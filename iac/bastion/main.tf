variable "vpc_id" {}
variable "public_subnet-1a_id" {}
variable "public_subnet-1b_id" {}
variable "aws_security_group_id" {}

resource "aws_instance" "web_server" {
  ami           = "ami-0dfdff9941ebfbd48"
  instance_type = "t2.micro"
  ///
  # key_name      = "terraform-key"
  subnet_id     = var.public_subnet-1a_id

  vpc_security_group_ids = [
   var.aws_security_group_id
  ]
}


# resource "aws_security_group" "db_sg" {
#   name        = "db_sg"
#   description = "Security group for databases"
#   vpc_id      = var.vpc_id


#   ingress {
#     description     = "Allow MySQL traffic from only the web sg"
#     from_port       = "3306"
#     to_port         = "3306"
#     protocol        = "tcp"
#     security_groups = [aws_security_group.ssh_access.id]
#   }

#   tags = {
#     Name = "db_sg"
#   }
# }

resource "aws_eip" "eip" {
  instance = aws_instance.web_server.id

  tags = {
    Name = "Gtest-eip"
  }
}