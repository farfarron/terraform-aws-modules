############################################
# OUTPUTS DEL MÓDULO ECS + FARGATE + ALB
############################################

# Nombre del ECS Cluster creado
output "ecs_cluster_name" {
  description = "Nombre del ECS Cluster creado"
  value       = aws_ecs_cluster.this.name
}

# ARN del Task Definition
output "ecs_task_definition_arn" {
  description = "ARN de la definición de tarea Fargate creada"
  value       = aws_ecs_task_definition.app.arn
}

# Nombre DNS del Load Balancer
output "alb_dns_name" {
  description = "Nombre DNS público (o interno) del Load Balancer"
  value       = aws_lb.alb.dns_name
}

# ARN del Load Balancer
output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = aws_lb.alb.arn
}

# ARN del Target Group
output "target_group_arn" {
  description = "ARN del Target Group asociado al ALB para ECS"
  value       = aws_lb_target_group.ecs_tg.arn
}

# ID del Security Group
output "security_group_id" {
  description = "ID del Security Group asignado al ALB"
  value       = aws_security_group.alb_sg.id
}
