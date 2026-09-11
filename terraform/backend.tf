terraform {
  backend "s3" {
    bucket = "todo-project-tfstate-202533497290-us-east-1-an"
    key    = "infra/terraform.tfstate"
    region = "us-east-1"
  }
}