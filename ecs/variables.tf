########################################
# VARIABLES DEL PROYECTO (RAÍZ)
########################################

# Región de AWS donde se desplegarán los recursos
variable "aws_region" {
  description = "Región AWS donde se creará la infraestructura (ej: us-east-1)"
  type        = string
}

# Perfil de AWS CLI a utilizar
variable "aws_profile" {
  description = "Perfil de AWS configurado localmente en ~/.aws/credentials"
  type        = string
}

# ID de la VPC existente
variable "vpc_id" {
  description = "ID de la VPC donde se desplegarán el ALB, el ECS y otros componentes"
  type        = string
}

# Lista de Subnets donde se ubicará el Load Balancer
variable "subnet_ids" {
  description = "Lista de IDs de subnets donde se ubicará el Load Balancer y las tareas Fargate"
  type        = list(string)
}

variable "ecr_image_url" {
  description = "URL completa de la imagen del contenedor a ejecutar en ECS (por ejemplo nginx o una URL de ECR)"
  type        = string
}

variable "cpu" {
  description = "Cantidad de CPU para las tareas Fargate"
  type        = number
}

variable "memory" {
  description = "Cantidad de memoria RAM para las tareas Fargate"
  type        = number
}

variable "cluster_name" {
  description = "Nombre del ECS Cluster que se creará"
  type        = string
}
