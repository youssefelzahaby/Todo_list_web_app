resource "aws_db_subnet_group" "todo_rds_subnet_group" {
  name = "todo-rds-subnet-group"

  subnet_ids = [
    aws_subnet.private_db_a.id,
    aws_subnet.private_db_b.id
  ]

  tags = {
    Name = "todo-rds-subnet-group"
  }
}



# =========================
# RDS MySQL
# =========================

resource "aws_db_instance" "todo_rds" {

  identifier     = "todo-rds"
  engine         = "mysql"
  engine_version = "8.4"

  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "todo_db"
  username = "todo_admin"
  password = random_password.db_password.result

  port = 3306

  db_subnet_group_name = aws_db_subnet_group.todo_rds_subnet_group.name

  vpc_security_group_ids = [
    aws_security_group.RDS-SG.id
  ]

  publicly_accessible = false

  multi_az = false

  backup_retention_period = 1

  deletion_protection = false
  skip_final_snapshot = true

  apply_immediately = true

  tags = {
    Name = "todo-rds"
  }

}