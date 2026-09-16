<div align="center">

# 📝 Todo List Web App

### Full-Stack Application • AWS • DevOps • CI/CD

A full-stack Todo application built with **Django REST Framework** and **Vanilla JavaScript**, containerized with Docker and deployed on AWS using **Terraform and GitHub Actions**.

<br>

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge\&logo=python\&logoColor=white)
![Django](https://img.shields.io/badge/Django-092E20?style=for-the-badge\&logo=django\&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge\&logo=javascript\&logoColor=black)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge\&logo=docker\&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-844FBA?style=for-the-badge\&logo=terraform\&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge\&logo=amazon-aws\&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge\&logo=github-actions\&logoColor=white)

</div>

---

## 📌 About

This project started as a simple **Full-Stack Web Application** and evolved into a hands-on **DevOps & AWS project**.

The goal was to take a working application and build a production-oriented cloud environment around it using:

**Docker → Terraform → AWS → CI/CD → Security → Scalability**

---

## ✨ Features

| Application           | DevOps & Cloud               |
| --------------------- | ---------------------------- |
| 🔐 JWT Authentication | 🐳 Dockerized Backend        |
| 👤 User Accounts      | 🏗️ Terraform IaC            |
| 📝 Task Management    | 🔄 GitHub Actions CI/CD      |
| ➕ Create Tasks        | 📦 Amazon ECR                |
| ✏️ Update Tasks       | ⚖️ Application Load Balancer |
| 🗑️ Delete Tasks      | 📈 Auto Scaling              |
| 📱 Responsive UI      | 🛡️ AWS WAF                  |
| 🌐 REST API           | 🔑 Secrets Manager           |

---

# 🏗️ AWS Architecture

<p align="center">
  <img src="docs/aws-architecture.png" alt="AWS Architecture" width="950">
</p>

The infrastructure is built around a multi-layer AWS architecture:

* **Amazon S3** hosts the frontend.
* **Application Load Balancer** distributes backend traffic.
* **Auto Scaling Group** runs multiple EC2 instances.
* **Docker** runs the Django application.
* **Amazon RDS MySQL** provides the database layer.
* **AWS WAF** protects the application entry point.
* **Amazon ECR** stores Docker images.
* **AWS SSM** is used for remote management and deployment.
* **AWS Secrets Manager** stores application and database secrets.

> **Note:** CloudFront is planned as a future improvement after AWS account verification.

---

# 🛠️ Technology Stack

## 🎨 Frontend

![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=flat-square\&logo=html5\&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=flat-square\&logo=css3\&logoColor=white)
![JavaScript](https://img.shields.io/badge/Vanilla_JS-F7DF1E?style=flat-square\&logo=javascript\&logoColor=black)

* HTML5
* CSS3
* Vanilla JavaScript
* Fetch API
* JWT token handling

## ⚙️ Backend

![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square\&logo=python\&logoColor=white)
![Django](https://img.shields.io/badge/Django-092E20?style=flat-square\&logo=django\&logoColor=white)

* Python
* Django
* Django REST Framework
* Gunicorn
* JWT Authentication
* MySQL

## ☁️ AWS

**Services used:**

`VPC` · `EC2` · `S3` · `RDS` · `ECR` · `ALB` · `ASG` · `WAF` · `IAM` · `SSM` · `Secrets Manager` · `CloudWatch`

## 🔧 DevOps

* 🐳 Docker
* 🏗️ Terraform
* 🔄 GitHub Actions
* 🔐 AWS OIDC
* 🔁 CI/CD
* 📦 Infrastructure as Code
* 🖥️ Remote deployment with SSM

---

# 🔄 CI/CD Pipeline

### Backend Deployment

<p align="center">
  <img src="docs/backend-cicd.png" alt="Backend CI/CD Pipeline" width="900">
</p>

The deployment flow is:

```text
Git Push
   ↓
GitHub Actions
   ↓
AWS OIDC
   ↓
Docker Build
   ↓
Amazon ECR
   ↓
AWS SSM
   ↓
EC2 Instances
   ↓
Django Migrations
   ↓
New Container
```

The Docker image is tagged using the **Git commit SHA**, allowing each deployment to reference a specific version of the application.

---

# 🔐 Security

The infrastructure was designed with security in mind:

* 🔑 **GitHub OIDC** instead of long-lived AWS credentials
* 🔒 Secrets stored in **AWS Secrets Manager**
* 🛡️ **AWS WAF** in front of the ALB
* 🔐 EC2 instances deployed in private application subnets
* 🗄️ RDS deployed in private database subnets
* 🚫 RDS is not publicly accessible
* 🔗 Security Groups control communication between layers
* 🖥️ AWS SSM used instead of SSH

---

# 🏗️ Infrastructure as Code

The AWS infrastructure is managed through **Terraform**.

```text
terraform/
│
├── network.tf
├── security.tf
├── alb.tf
├── asg.tf
├── rds.tf
├── ecr.tf
├── s3.tf
├── secrets.tf
├── iam.tf
├── waf.tf
├── cloudwatch.tf
├── backend.tf
├── providers.tf
├── variables.tf
└── outputs.tf
```

Terraform state is stored remotely using an **Amazon S3 backend**.

---

# 📂 Project Structure

```text
Todo_list_web_app/
│
├── frontend/
│   ├── Html/
│   ├── CSS/
│   ├── JavaScript/
│   └── config.js
│
├── backend/
│   ├── api/
│   ├── manage.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── terraform/
│
├── docs/
│   ├── aws-architecture.png
│   └── backend-cicd.png
│
└── .github/
    └── workflows/
```

---

# 📚 What I Practiced

This project gave me hands-on experience with:

```text
Linux
  ↓
Git & GitHub
  ↓
Docker
  ↓
Terraform
  ↓
AWS Networking
  ↓
IAM & OIDC
  ↓
CI/CD
  ↓
Load Balancing
  ↓
Auto Scaling
  ↓
Secrets Management
  ↓
Monitoring & Security
```

---

# 🔮 Future Improvements

* ☸️ Kubernetes
* ⎈ Helm
* 🔄 Argo CD / GitOps
* 🔐 HTTPS + Custom Domain
* 🌍 CloudFront
* 📊 Advanced Monitoring
* 🧪 Automated Testing
* 🚀 Zero-Downtime Deployment

---

<div align="center">

### 👨‍💻 Yousef Elzahaby

**DevOps / Cloud Engineering Journey**

⭐ If you find this project useful, feel free to explore the repository.

</div>
