# 📝 Todo List Web App

A full-stack Todo List application built with **Django REST Framework** and **Vanilla JavaScript**, then deployed to AWS using **Docker, Terraform, and GitHub Actions**.

The project was built to practice real-world **DevOps, Cloud, Infrastructure as Code, CI/CD, security, and scalable application deployment**.

---

## 🏗️ Architecture

```text
                         ┌──────────────┐
                         │    Browser   │
                         └──────┬───────┘
                                │
                 ┌──────────────┴──────────────┐
                 │                             │
                 ▼                             ▼
          ┌─────────────┐              ┌─────────────┐
          │   S3        │              │     WAF     │
          │  Frontend   │              └──────┬──────┘
          └─────────────┘                     │
                                              ▼
                                      ┌─────────────┐
                                      │     ALB     │
                                      └──────┬──────┘
                                             │
                                      ┌──────▼──────┐
                                      │     ASG     │
                                      │  EC2 x2+   │
                                      │   Docker    │
                                      └──────┬──────┘
                                             │
                         ┌───────────────────┼───────────────────┐
                         ▼                   ▼                   ▼
                   ┌──────────┐      ┌─────────────┐      ┌──────────┐
                   │   RDS    │      │   Secrets   │      │   ECR    │
                   │  MySQL   │      │  Manager    │      │  Images  │
                   └──────────┘      └─────────────┘      └──────────┘


              ┌─────────────────┐
              │ GitHub Actions  │
              └────────┬────────┘
                       │ OIDC
                       ▼
                ┌─────────────┐
                │  AWS IAM    │
                └──────┬──────┘
                       │
              ┌────────┴────────┐
              ▼                 ▼
           ECR Push         SSM Deploy
                                │
                                ▼
                              EC2
```

---

## 🚀 Features

* 🔐 JWT Authentication
* 👤 User-specific tasks
* ✅ Create / Read / Update / Delete tasks
* 🌐 RESTful API
* 📱 Responsive frontend
* 🐳 Dockerized backend
* ☁️ AWS deployment
* 🏗️ Terraform Infrastructure as Code
* 🔄 GitHub Actions CI/CD
* 🔑 AWS Secrets Manager
* 🛡️ AWS WAF
* ⚖️ Application Load Balancer
* 📈 EC2 Auto Scaling
* 🗄️ Amazon RDS MySQL
* 📦 Amazon ECR
* 🔧 AWS Systems Manager

---

## 🛠️ Tech Stack

### Frontend

![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=flat\&logo=html5\&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=flat\&logo=css3\&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat\&logo=javascript\&logoColor=black)

### Backend

![Python](https://img.shields.io/badge/Python-3776AB?style=flat\&logo=python\&logoColor=white)
![Django](https://img.shields.io/badge/Django-092E20?style=flat\&logo=django\&logoColor=white)
![DRF](https://img.shields.io/badge/DRF-A30000?style=flat\&logo=django\&logoColor=white)

### DevOps & Cloud

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat\&logo=docker\&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-844FBA?style=flat\&logo=terraform\&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat\&logo=github-actions\&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat\&logo=amazon-aws\&logoColor=white)

### AWS Services

`S3` · `EC2` · `ALB` · `ASG` · `RDS` · `ECR` · `WAF` · `IAM` · `SSM` · `Secrets Manager` · `VPC`

---

## 🔄 CI/CD

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
EC2
   ↓
Database Migration
   ↓
New Container
```

The backend image is tagged using the **Git commit SHA** and deployed to the EC2 instances through AWS Systems Manager.

---

## 🔐 Security

* 🔑 GitHub Actions → AWS using **OIDC**
* 🔒 No static AWS credentials in GitHub Actions
* 🗝️ Secrets stored in **AWS Secrets Manager**
* 🛡️ AWS WAF protects the ALB
* 🔐 Private subnets for application and database layers
* 🚫 RDS is not publicly accessible
* 🔗 Security Groups restrict traffic between layers
* 🖥️ SSM used instead of SSH for deployment and management

---

## 🏗️ Infrastructure as Code

All AWS infrastructure is managed using **Terraform**.

```text
terraform/
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

## 📂 Project Structure

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
└── .github/
    └── workflows/
```

---

## 🎯 Project Goal

This project started as a **Full-Stack Web Development** project and evolved into a hands-on **DevOps & AWS project**.

The goal was to apply:

**Docker → Terraform → AWS → CI/CD → Security → Scalability**

in a realistic deployment environment.

---

## 🔮 Future Improvements

* ☸️ Kubernetes
* ⎈ Helm
* 🔄 Argo CD / GitOps
* 📊 Monitoring & centralized logging
* 🔐 HTTPS + Custom Domain
* 🌍 CloudFront
* 🧪 Automated testing
* 🚀 Improved zero-downtime deployments

---

## 👨‍💻 Author

**Yousef Elzahaby**

Built with ❤️ while learning and applying **DevOps, AWS, Docker, Terraform, and Cloud technologies**.
