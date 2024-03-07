variable "vpc_id" {}
variable "private_subnet-1a_id" {}
variable "private_subnet-1b_id" {}

 resource "aws_db_instance" "default" {
  allocated_storage           = 10
  db_name                     = "postgresql"
  engine                      = "postgresql"
  engine_version              = "16.1-R2"
  instance_class              = "db.m5d.large"
  manage_master_user_password = true
  username                    = "foo"
  parameter_group_name        = "default.postgresql16"
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.postgresql.id
  instance_class     = "db.t3.micro"
  engine             = aws_rds_cluster.postgresql.engine
  engine_version     = aws_rds_cluster.postgresql.engine_version

  //- Enable RDS performance insights.
  performance_insights_enabled = true
}

resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-postgresql"
  availability_zones      = ["eu-west-3a", "eu-west-3b"]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "barbarbar"
  //- RDS Postgresql with weekly backups, retaining for 4 weeks.
  backup_retention_period = 4*7
  preferred_backup_window = "07:00-09:00"
}

resource "aws_db_cluster_snapshot" "example" {
  db_cluster_identifier          = aws_rds_cluster.postgresql.id
  db_cluster_snapshot_identifier = "resourcetestsnapshot1234"
}

# availability_zones = ["eu-west-3a", "eu-west-3b"]
resource "aws_db_subnet_group" "default" {
  name       = "main"
   subnet_ids = [var.private_subnet-1a_id, var.private_subnet-1b_id]
  #  subnet_ids = [aws_subnet.frontend.id, aws_subnet.backend.id]

  tags = {
    Name = "My DB subnet group"
  }
}



# //nacl  network acl
# //- NACLs with custom rules for different subnets.
# resource "aws_network_acl" "main" {
#   vpc_id = var.vpc_id

#   egress {
#     protocol   = "tcp"
#     rule_no    = 200
#     action     = "allow"
#     cidr_block = "10.3.0.0/18"
#     from_port  = 443
#     to_port    = 443
#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "10.3.0.0/18"
#     from_port  = 80
#     to_port    = 80
#   }
#   egress {
#     protocol   = "tcp"
#     rule_no    = 200
#     action     = "allow"
#     cidr_block = "10.4.0.0/18"
#     from_port  = 443
#     to_port    = 443
#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "10.4.0.0/18"
#     from_port  = 80
#     to_port    = 80
#   }

#   tags = {
#     Name = "main"
#   }
# }
