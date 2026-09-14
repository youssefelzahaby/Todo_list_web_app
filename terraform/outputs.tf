output "frontend_bucket_name" {
  value = aws_s3_bucket.frontend.bucket
}

output "alb_dns_name" {
  value = aws_lb.ALB.dns_name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.todo_backend.repository_url
}
output "secret_arn" {
  value = aws_secretsmanager_secret.backend_credentials.arn
}

output "frontend_website_url" {
  value = "http://${aws_s3_bucket.frontend.bucket}.s3-website-${data.aws_region.current.name}.amazonaws.com"
}