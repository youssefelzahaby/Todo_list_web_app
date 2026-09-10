# ==========================================
# IAM Role for EC2
# ==========================================

resource "aws_iam_role" "ec2_role" {
  name = "todo-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "todo-ec2-role"
    Environment = "pro"
  }
}


# ==========================================
# ECR Permissions
# ==========================================

resource "aws_iam_role_policy" "ec2_ecr_policy" {
  name = "todo-ec2-ecr-policy"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ecr:GetAuthorizationToken"
        ]

        Resource = "*"
      },
      {
        Effect = "Allow"

        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]

        Resource = aws_ecr_repository.todo_backend.arn
      }
    ]
  })
}


# ==========================================
# Secrets Manager Permissions
# ==========================================

resource "aws_iam_role_policy" "ec2_secrets_policy" {
  name = "todo-ec2-secrets-policy"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue"
        ]

        Resource = aws_secretsmanager_secret.backend_credentials.arn
      }
    ]
  })
}


# ==========================================
# Instance Profile
# ==========================================

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "todo-ec2-profile"

  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}