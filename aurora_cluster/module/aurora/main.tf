resource "aws_db_subnet_group" "aurora" {
  name       = "${var.aurora_cluster_identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "Aurora subnet group"
  }
}

resource "aws_security_group" "aurora_sg" {
  name        = "${var.aurora_cluster_identifier}-sg"
  description = "Permite acceso a Aurora"
  vpc_id      = var.vpc_id
}

resource "random_password" "db_password" {
  length  = 16
  special = false
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier     = var.aurora_cluster_identifier
  engine                 = "aurora-mysql"
  engine_version         = var.aurora_engine_version
  master_username        = var.aurora_master_username
  master_password        = random_password.db_password.result
  db_subnet_group_name   = aws_db_subnet_group.aurora.name
  vpc_security_group_ids = [aws_security_group.aurora_sg.id]
  skip_final_snapshot    = true

  tags = {
    Name = var.aurora_cluster_identifier
  }
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  identifier           = "${var.aurora_cluster_identifier}-instance-1"
  cluster_identifier   = aws_rds_cluster.aurora.id
  instance_class       = var.aurora_instance_class
  engine               = aws_rds_cluster.aurora.engine
  engine_version       = aws_rds_cluster.aurora.engine_version
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.aurora.name

  tags = {
    Name = "aurora-instance"
  }
}

