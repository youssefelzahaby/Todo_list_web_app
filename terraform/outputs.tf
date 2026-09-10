output "frontend_bucket_name" {
  value = aws_s3_bucket.frontend.bucket
}

output "alb_dns_name" {
  value = aws_lb.ALB.dns_name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.todo_backend.repository_url
}