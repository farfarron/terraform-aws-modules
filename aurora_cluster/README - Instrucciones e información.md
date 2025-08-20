# Terraform Module: Aurora RDS (Aurora MySQL)

Este módulo de Terraform permite desplegar un clúster de Amazon Aurora (MySQL) usando una VPC y subredes privadas **preexistentes**. No se permite acceso público — la conectividad debe hacerse desde dentro de la VPC.

---

## 🚀 Uso rápido

```hcl
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
```

---

## 🧾 Configuración por entorno

Todos los valores se deben definir en un archivo `terraform.tfvars`. Aquí tienes un ejemplo comentado:

```hcl
# Región donde desplegar los recursos (por ejemplo, us-east-1)
aws_region = "us-east-1"

# ID de la VPC donde se desplegará Aurora
vpc_id = "vpc-0123456789abcdef0"

# Lista de subnets privadas (al menos 2 en diferentes AZs)
subnet_ids = [
  "subnet-0123456789abcdef0",
  "subnet-0fedcba9876543210"
]

# Nombre del clúster Aurora (debe ser único en la región)
aurora_cluster_identifier = "dev-aurora-cluster"

# Versión de Aurora compatible (ejemplo: 5.7.mysql_aurora.2.11.3)
aurora_engine_version = "5.7.mysql_aurora.2.11.3"

# Nombre del usuario administrador de la base de datos
aurora_master_username = "admin"

# Tipo de instancia (ejemplo: db.t3.medium, db.r5.large, etc.)
aurora_instance_class = "db.t3.medium"
```

---

## 📥 Inputs requeridos

> ⚠️ Todas las variables son requeridas. No se establecen valores por defecto.

| Variable                     | Descripción                                      | Tipo        |
|-----------------------------|--------------------------------------------------|-------------|
| aws_region                  | Región de AWS                                    | `string`    |
| vpc_id                      | ID de la VPC existente                           | `string`    |
| subnet_ids                  | Lista de subnets privadas                        | `list(string)` |
| aurora_cluster_identifier   | Nombre del clúster                               | `string`    |
| aurora_engine_version       | Versión del motor                                | `string`    |
| aurora_master_username      | Usuario admin                                    | `string`    |
| aurora_instance_class       | Clase de instancia                               | `string`    |

---

## 📤 Outputs

| Output                  | Descripción                                 |
|-------------------------|---------------------------------------------|
| aurora_endpoint         | Endpoint del clúster Aurora                 |
| aurora_reader_endpoint  | Reader endpoint                             |
| aurora_cluster_id       | ID del clúster                              |
| aurora_instance_id      | ID de la instancia                          |
| db_password             | Contraseña generada (sensible)              |

---

## 🧪 Comandos para ejecutar

```bash
terraform init
terraform apply -var-file="terraform.tfvars"
```

---

## ✅ Requisitos

- Terraform >= 1.0
- AWS CLI configurado
- Una VPC y subredes privadas ya creadas en la región seleccionada

---

## 🔒 Seguridad y buenas prácticas

- ❌ No se permite acceso público al clúster Aurora.
- ✅ La contraseña del administrador se genera de forma aleatoria y se expone como output sensible.
- ☁️ Aurora se desplegará en modo privado dentro de las subnets que definas.

---


---

## 🔐 Autenticación con AWS

Este módulo usa el **perfil de AWS CLI configurado localmente** para autenticarse contra tu cuenta de AWS.

### 🧰 Requisitos previos

1. Tener [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) instalado
2. Ejecutar el siguiente comando para configurar tus credenciales:

```bash
aws configure --profile mi-perfil-dev
```

Te pedirá:

- AWS Access Key ID
- AWS Secret Access Key
- Región por defecto (ej. `us-east-1`)
- Formato de salida (puedes dejarlo en blanco)

Esto guardará tus credenciales en el archivo `~/.aws/credentials`.

### 🛠 Cómo usar el perfil en Terraform

Este módulo permite pasar el nombre del perfil como variable:

```hcl
variable "aws_profile" {
  description = "Perfil de AWS configurado en ~/.aws/credentials"
  type        = string
}
```

Y en tu archivo `terraform.tfvars`:

```hcl
aws_profile = "mi-perfil-dev"
```

El proveedor de AWS se configura así:

```hcl
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
```

> Si no defines `aws_profile`, Terraform usará el perfil por defecto (`default`) si existe, o intentará usar variables de entorno.

---
