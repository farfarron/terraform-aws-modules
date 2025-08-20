# Región donde desplegar los recursos (por ejemplo, us-east-1)
aws_region = "us-east-1"

# Perfil de AWS a usar. Se debe tener AWS CLI instalada previamente y configurar un perfil .aws/credentials
aws_profile = "default"


# ID de la VPC donde se desplegará Aurora
vpc_id = "vpc-0e5d3dec1fc2728aa"

# Lista de subnets privadas (al menos 2 en diferentes AZs)
subnet_ids = [
  "subnet-097c3750327d3033d",
  "subnet-0b4b300e90d772a2a"
]

# Nombre del clúster Aurora (debe ser único en la región)
aurora_cluster_identifier = "dev-aurora-cluster"

# Versión de Aurora compatible (ejemplo: 5.7.mysql_aurora.2.11.3)
aurora_engine_version = "5.7.mysql_aurora.2.11.3"

# Nombre del usuario administrador de la base de datos
aurora_master_username = "admin"

# Tipo de instancia (ejemplo: db.t3.medium, db.r5.large, etc.)
aurora_instance_class = "db.t3.medium"
