########################################
# VARIABLES DEL MÓDULO ECS + FARGATE + ALB
########################################

# ID de la VPC donde se desplegarán los recursos
variable "vpc_id" {
  description = "ID de la VPC donde se desplegará el Load Balancer, Security Group y el Target Group."
  type        = string
}

# Lista de IDs de las Subnets donde se ubicará el Load Balancer
variable "subnet_ids" {
  description = "Lista de IDs de subnets (públicas o privadas) donde se desplegará el Load Balancer."
  type        = list(string)
}

# URL de la imagen de contenedor a desplegar
# Puede ser una imagen pública (como nginx) o una privada en Amazon ECR
variable "ecr_image_url" {
  description = "URL completa de la imagen del contenedor que se ejecutará en el ECS Service (ej: 123456789012.dkr.ecr.us-east-1.amazonaws.com/mi-aplicacion:latest)."
  type        = string
}


# Cantidad de CPU para las tareas Fargate (valores válidos: 256, 512, 1024, 2048, 4096)
variable "cpu" {
  description = "Cantidad de CPU para las tareas Fargate (por ejemplo: 256 = 0.25 vCPU)"
  type        = number
}

# Cantidad de memoria RAM para las tareas Fargate en MB (por ejemplo: 512, 1024, 2048)
variable "memory" {
  description = "Cantidad de memoria RAM (en MB) para las tareas Fargate"
  type        = number
}

# Nombre que se asignará al ECS Cluster
variable "cluster_name" {
  description = "Nombre del ECS Cluster que se creará"
  type        = string
}
