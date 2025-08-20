variable "aws_region" {
  type        = string
  description = "Región de AWS"
}

variable "aws_profile" {
  description = "Perfil de AWS configurado en ~/.aws/credentials"
  type        = string
}

variable "vpc_id" {
  type        = string
  description = "ID de la VPC donde se desplegará Aurora"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Lista de subnets privadas donde se desplegará Aurora"
}

variable "aurora_cluster_identifier" {
  type        = string
  description = "Identificador del clúster Aurora"
}

variable "aurora_engine_version" {
  type        = string
  description = "Versión del motor Aurora a utilizar"
}

variable "aurora_master_username" {
  type        = string
  description = "Usuario administrador de la base de datos Aurora"
}

variable "aurora_instance_class" {
  type        = string
  description = "Clase de instancia para la base de datos Aurora"
}
