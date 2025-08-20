variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC existente donde se desplegará Aurora"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnets privadas para el DB Subnet Group"
  type        = list(string)
}

variable "aurora_cluster_identifier" {
  description = "Nombre único del clúster Aurora"
  type        = string
}

variable "aurora_engine_version" {
  description = "Versión del motor Aurora MySQL"
  type        = string
}

variable "aurora_master_username" {
  description = "Usuario administrador del clúster"
  type        = string
}

variable "aurora_instance_class" {
  description = "Clase de instancia para la base de datos"
  type        = string
}
