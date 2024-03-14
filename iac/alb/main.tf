variable "vpc_id" {}
variable "public_subnet-1a_id" {}
variable "public_subnet-1b_id" {}
variable "aws_security_group_id" {}
# variable "aws_s3_bucket_id" {}

resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.aws_security_group_id]
  subnets            = [var.aws_security_group_id,var.public_subnet-1b_id]

  enable_deletion_protection = true

  # access_logs {
  #   bucket  = var.aws_s3_bucket_id
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "alb-example" {
  name        = "tf-example-lb-alb-tg"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id
}

# # Application Load balancer
# resource "aws_lb" "test" {
#   name               = "alb-tf"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group_id.ssh_access.id]
#   subnets            = [public_subnet-1a_id,public_subnet-1b_id]

#   tags = {
#     Environment = "production"
#   }
# }