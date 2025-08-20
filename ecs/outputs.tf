########################################
# OUTPUTS DEL PROYECTO (RAÍZ)
# Exponiendo salidas relevantes del módulo ECS
########################################

output "ecs_cluster_name" {
  description = "Nombre del ECS Cluster creado"
  value       = module.ecs_cluster.ecs_cluster_name
}

output "ecs_task_definition_arn" {
  description = "ARN de la definición de tarea Fargate creada"
  value       = module.ecs_cluster.ecs_task_definition_arn
}

output "alb_dns_name" {
  description = "DNS del Load Balancer para acceso a la aplicación"
  value       = module.ecs_cluster.alb_dns_name
}

output "alb_arn" {
  description = "ARN del Load Balancer creado"
  value       = module.ecs_cluster.alb_arn
}

output "target_group_arn" {
  description = "ARN del Target Group creado para ECS"
  value       = module.ecs_cluster.target_group_arn
}

output "security_group_id" {
  description = "ID del Security Group asignado al ALB"
  value       = module.ecs_cluster.security_group_id
}
