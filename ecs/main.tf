########################################
# MAIN DE RAÍZ
# Invocación del módulo ECS + ALB
########################################

module "ecs_cluster" {
  source = "./module/ecs_cluster"

  # Variables que recibe el módulo
  vpc_id         = var.vpc_id
  subnet_ids     = var.subnet_ids
  ecr_image_url  = var.ecr_image_url
  cpu            = var.cpu
  memory         = var.memory
  cluster_name   = var.cluster_name

  providers = {
    aws = aws
  }
}
