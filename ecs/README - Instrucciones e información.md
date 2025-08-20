
# 🚀 Proyecto Terraform: ECS Cluster con Fargate + ALB

Este proyecto de Terraform crea automáticamente una infraestructura en AWS que incluye:

- Un ECS Cluster con Fargate.
- Un Application Load Balancer (ALB).
- Un Target Group.
- Un Security Group asociado.
- Una definición de tarea (Task Definition) de tipo Fargate.
- Un Servicio ECS que despliega un contenedor desde una imagen pública o privada (ECR o DockerHub).

---

## 📂 Estructura del proyecto

```
├── main.tf              # Llama al módulo
├── outputs.tf           # Exporta outputs relevantes
├── providers.tf         # Configura el provider AWS
├── terraform.tfvars     # Define los valores de variables
├── variables.tf         # Declara las variables
└── module/
    └── ecs_cluster/
        ├── main.tf      # Define la infraestructura
        ├── outputs.tf   # Exporta outputs del módulo
        ├── providers.tf # Dependencia del provider
        └── variables.tf # Variables del módulo
```

---

## ⚙️ Variables principales

Se deben definir en el archivo `terraform.tfvars`:

| Variable         | Descripción                                                                 |
|------------------|-----------------------------------------------------------------------------|
| `aws_region`      | Región AWS donde se desplegarán los recursos.                              |
| `aws_profile`     | Perfil de AWS configurado localmente (`~/.aws/credentials`).               |
| `vpc_id`          | ID de la VPC donde se desplegarán los recursos.                             |
| `subnet_ids`      | Lista de IDs de subnets para el ALB y las tareas Fargate.                   |
| `ecr_image_url`   | URL completa de la imagen Docker a desplegar (DockerHub o ECR).             |
| `cpu`             | CPU para la tarea Fargate (valores permitidos: 256, 512, 1024, 2048, 4096). |
| `memory`          | Memoria RAM para la tarea Fargate (en MB).                                 |
| `cluster_name`    | Nombre que tendrá el ECS Cluster.                                          |

---

## 📄 Ejemplo de `terraform.tfvars`

```hcl
aws_region    = "us-east-1"
aws_profile   = "default"

vpc_id        = "vpc-0123456789abcdef0"
subnet_ids    = [
  "subnet-0123456789abcdef0",
  "subnet-0fedcba9876543210"
]

ecr_image_url = "nginx:latest"  # Puede ser pública o privada (ej: ECR URL)
cpu           = 256             # 0.25 vCPU
memory        = 512             # 512 MB RAM
cluster_name  = "internal-ecs-cluster"
```

---

## 🚀 Pasos para desplegar

1. Inicializar el proyecto:

```bash
terraform init
```

2. Validar la configuración:

```bash
terraform validate
```

3. Ver el plan de creación:

```bash
terraform plan
```

4. Aplicar los cambios:

```bash
terraform apply
```

✅ Terraform solicitará confirmación antes de crear los recursos.

---

## 🌐 Acceso a la aplicación

Después de aplicar, Terraform mostrará los **outputs** incluyendo:

- El **DNS del ALB** (`alb_dns_name`).

Puedes acceder a tu aplicación visitando ese DNS en el navegador, si tu security group lo permite (HTTP 80 abierto).

---

## ⚠️ Advertencias importantes

- El **Security Group** creado permite tráfico HTTP (puerto 80) desde **cualquier IP (`0.0.0.0/0`)**.  
  ➔ Se recomienda modificar esta configuración en producción.
- El ALB está configurado como **interno** (`internal = true`).  
  ➔ Cambiarlo a `internal = false` si deseas exponerlo a internet público.
- Los valores de `cpu` y `memory` deben respetar las combinaciones válidas para **AWS Fargate**.
- El rol de ejecución (IAM Role) permite acceso a ECR y CloudWatch Logs.

---

## 🛠️ Cómo destruir la infraestructura

Para destruir todos los recursos creados:

```bash
terraform destroy
```

⚠️ Este comando eliminará toda la infraestructura desplegada por este proyecto.

---

## 📞 Soporte

Si necesitas ayuda adicional, contacta al administrador del proyecto o revisa la [documentación oficial de AWS ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html).

---
