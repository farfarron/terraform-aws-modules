output "aurora_endpoint" {
  value = aws_rds_cluster.aurora.endpoint
}

output "aurora_reader_endpoint" {
  value = aws_rds_cluster.aurora.reader_endpoint
}

output "aurora_cluster_id" {
  value = aws_rds_cluster.aurora.id
}

output "aurora_instance_id" {
  value = aws_rds_cluster_instance.aurora_instance.id
}

output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}
