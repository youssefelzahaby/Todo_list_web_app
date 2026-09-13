# ==========================================
# Ubuntu AMI
# ==========================================

data "aws_ssm_parameter" "ubuntu_ami" {

  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"

}


# ==========================================
# Current AWS Region
# ==========================================

data "aws_region" "current" {}


# ==========================================
# Launch Template
# ==========================================

resource "aws_launch_template" "app" {

  name          = "todo-app-template"
  instance_type = "t3.micro"

  image_id = data.aws_ssm_parameter.ubuntu_ami.value


  # ------------------------------------------
  # IAM Instance Profile
  # ------------------------------------------

  iam_instance_profile {

    name = aws_iam_instance_profile.ec2_profile.name

  }


  # ------------------------------------------
  # Security Group  
  # ------------------------------------------

  network_interfaces {

    security_groups = [
      aws_security_group.EC2-SG.id
    ]

  }

user_data = base64encode(<<-EOF
  #!/bin/bash

  # ==========================================
  # Exit on errors
  # ==========================================

  set -e


  # ==========================================
  # Wait for network
  # ==========================================

  sleep 10


  # ==========================================
  # Update package lists with retry
  # ==========================================

  for i in {1..5}; do
    if apt-get update -y; then
      echo "apt update succeeded."
      break
    fi

    echo "apt update failed. Retrying in 10 seconds..."
    sleep 10

    if [ "$i" -eq 5 ]; then
      echo "apt update failed after 5 attempts."
      exit 1
    fi
  done


  # ==========================================
  # Install required dependencies
  # ==========================================

  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    docker.io \
    jq \
    curl \
    unzip


  # ==========================================
  # Install AWS CLI v2
  # ==========================================

  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
    -o "/tmp/awscliv2.zip"

  unzip -q /tmp/awscliv2.zip -d /tmp

  /tmp/aws/install

  rm -rf /tmp/aws /tmp/awscliv2.zip


  # ==========================================
  # Enable and start Docker
  # ==========================================

  systemctl enable docker
  systemctl start docker


  # ==========================================
  # Verify Docker and AWS CLI
  # ==========================================

  docker --version
  aws --version
  jq --version


  # ==========================================
  # Variables
  # ==========================================

  AWS_REGION="${data.aws_region.current.region}"

  ECR_REPOSITORY="${aws_ecr_repository.todo_backend.repository_url}"

  ECR_REGISTRY=$(echo "$ECR_REPOSITORY" | cut -d'/' -f1)

  SECRET_ARN="${aws_secretsmanager_secret.backend_credentials.arn}"

  IMAGE_TAG="latest"


  # ==========================================
  # Login to ECR
  # ==========================================

  aws ecr get-login-password \
    --region "$AWS_REGION" | \
    docker login \
      --username AWS \
      --password-stdin "$ECR_REGISTRY"


  # ==========================================
  # Pull Docker Image
  # ==========================================

  docker pull "$ECR_REPOSITORY:$IMAGE_TAG"


  # ==========================================
  # Get Secrets
  # ==========================================

  SECRET=$(aws secretsmanager get-secret-value \
    --secret-id "$SECRET_ARN" \
    --query SecretString \
    --output text)


  # ==========================================
  # Extract Environment Variables
  # ==========================================

  DB_NAME=$(echo "$SECRET" | jq -r '.DB_NAME')

  DB_USER=$(echo "$SECRET" | jq -r '.DB_USER')

  DB_PASSWORD=$(echo "$SECRET" | jq -r '.DB_PASSWORD')

  DB_HOST=$(echo "$SECRET" | jq -r '.DB_HOST')

  DB_PORT=$(echo "$SECRET" | jq -r '.DB_PORT')

  SECRET_KEY=$(echo "$SECRET" | jq -r '.SECRET_KEY')


  # ==========================================
  # Run Backend Container
  # ==========================================

  docker run -d \
    --name todo-backend \
    --restart unless-stopped \
    -p 80:8000 \
    -e DB_NAME="$DB_NAME" \
    -e DB_USER="$DB_USER" \
    -e DB_PASSWORD="$DB_PASSWORD" \
    -e DB_HOST="$DB_HOST" \
    -e DB_PORT="$DB_PORT" \
    -e SECRET_KEY="$SECRET_KEY" \
    "$ECR_REPOSITORY:$IMAGE_TAG"


  # ==========================================
  # Bootstrap Completed
  # ==========================================

  echo "=========================================="
  echo "EC2 bootstrap completed."
  echo "Docker installed successfully."
  echo "AWS CLI installed successfully."
  echo "Backend container started."
  echo "=========================================="

EOF
)
}


# ==========================================
# Auto Scaling Group
# ==========================================

resource "aws_autoscaling_group" "ASG" {

  name = "todo-app-asg"
  tag {

  key = "SSM"
  value = "todo-app"
  propagate_at_launch = true

}

  min_size = 2

  max_size = 4

  desired_capacity = 2


  # ------------------------------------------
  # Private Subnets
  # ------------------------------------------

  vpc_zone_identifier = [

    aws_subnet.private_app_a.id,

    aws_subnet.private_app_b.id

  ]


  # ------------------------------------------
  # ALB Target Group
  # ------------------------------------------

  target_group_arns = [

    aws_lb_target_group.TG.arn

  ]


  # ------------------------------------------
  # Launch Template
  # ------------------------------------------

  launch_template {

    id = aws_launch_template.app.id

    version = "$Latest"

  }


  # ------------------------------------------
  # EC2 Tags
  # ------------------------------------------

  tag {

    key = "Name"

    value = "todo-app"

    propagate_at_launch = true

  }

} 