output "ecr_repo_url" {
  value = aws_ecr_repository.fc572-ecr-repo.repository_url
}

output "load_balancer_url" {
  value = aws_alb.application_load_balancer.dns_name
}