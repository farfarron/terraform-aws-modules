output "aurora_endpoint" {
  value = module.aurora.aurora_endpoint
}

output "aurora_reader_endpoint" {
  value = module.aurora.aurora_reader_endpoint
}

output "aurora_cluster_id" {
  value = module.aurora.aurora_cluster_id
}

output "aurora_instance_id" {
  value = module.aurora.aurora_instance_id
}

output "db_password" {
  value     = module.aurora.db_password
  sensitive = true
}
