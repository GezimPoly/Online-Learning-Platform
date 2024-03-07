variable "public_subnet-1a_id" {}
variable "public_subnet-1b_id" {}


data "aws_ami" "ubuntu" {
  most_recent = true

  # filter {
  #   name   = "name"
  #   values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  # }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "as_conf" {
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  // me vet
  # spot_price    = "0.001"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bar" {
  name                 = "OLN-autoscaling"
  launch_configuration = aws_launch_configuration.as_conf.name
  vpc_zone_identifier  = [module.vpc.public_subnet-1a_id,module.vpc.public_subnet-1b_id]

  min_size             = 1
  max_size             = 2

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_policy" "bat" {
  name                   = "autoscaling policy"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.bar.name
}

resource "aws_cloudwatch_metric_alarm" "bat" {
  alarm_name          = "cloudwatch-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.bar.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.bat.arn]
}

resource "aws_placement_group" "test" {
  name     = "testt"
  strategy = "cluster"
}
