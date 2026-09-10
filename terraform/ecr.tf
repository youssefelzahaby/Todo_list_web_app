resource "aws_ecr_repository" "todo_backend" {
  name = "todo-backend"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "todo-backend"
    Environment = "pro"
  }
}