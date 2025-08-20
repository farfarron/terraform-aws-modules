module "aurora" {
  source = "./module/aurora"

  aws_region                = var.aws_region
  vpc_id                    = var.vpc_id
  subnet_ids                = var.subnet_ids
  aurora_cluster_identifier = var.aurora_cluster_identifier
  aurora_engine_version     = var.aurora_engine_version
  aurora_master_username    = var.aurora_master_username
  aurora_instance_class     = var.aurora_instance_class
}

