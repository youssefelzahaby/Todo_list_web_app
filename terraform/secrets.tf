# Create a random password for the database user
resource "random_password" "db_password" {
  length  = 32
  special = true

  override_special = "!#$%&*+-=?^_"
}


# Create a random string for the Django secret key
resource "random_string" "django_secret_key" {
  length = 64

  special = true
  upper   = true
  lower   = true
  numeric = true

  keepers = {
    project = "todo-backend"
  }
}


# Create a Secrets Manager secret
resource "aws_secretsmanager_secret" "backend_credentials" {
  name                    = "backend-credentials"
  description             = "Backend application credentials"
  recovery_window_in_days = 0
  
  tags = {
    Name = "backend-credentials"
  }
}


# Store the secret values
resource "aws_secretsmanager_secret_version" "backend_credentials" {
  secret_id = aws_secretsmanager_secret.backend_credentials.id

  secret_string = jsonencode({
    DB_NAME     = "todo_db"
    DB_USER     = "todo_admin"
    DB_PASSWORD = random_password.db_password.result
    DB_HOST     = aws_db_instance.todo_rds.address
    DB_PORT     = "3306"
    SECRET_KEY  = random_string.django_secret_key.result
  })
}
