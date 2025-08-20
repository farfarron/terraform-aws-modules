########################################
# VARIABLES DE CONFIGURACIÓN
# Ajustar estos valores según su entorno
########################################

# Región AWS donde se crearán los recursos
aws_region = "us-east-1"

# Perfil de AWS configurado en la máquina local
aws_profile = "default"

# ID de la VPC existente donde desplegar la infraestructura
vpc_id = "vpc-0e5d3dec1fc2728aa"

# Lista de IDs de Subnets disponibles (públicas o privadas)
subnet_ids = [
  "subnet-097c3750327d3033d",
  "subnet-0b4b300e90d772a2a"
]

# URL de la imagen a utilizar en ECS (puede ser privada en ECR o pública)
ecr_image_url = "nginx"

# CPU para las tareas Fargate
cpu = 256

# Memoria RAM para las tareas Fargate
memory = 512

# Nombre del ECS Cluster
cluster_name = "internal-ecs-cluster"