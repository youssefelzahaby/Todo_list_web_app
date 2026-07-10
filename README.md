# 📝 Todo List Web App

A full-stack Todo List web application built with **Django REST Framework** for the backend and **HTML, CSS, and JavaScript** for the frontend. The application enables users to securely manage their daily tasks through a clean, responsive, and intuitive interface.

## 🚀 Features

- User Registration & Login
- JWT Authentication
- User-specific task management
- Delete tasks
- Responsive user interface
- RESTful API

## 🛠️ Tech Stack

### Frontend
- HTML5
- CSS3
- JavaScript (Vanilla JS)

### Backend
- Python
- Django
- Django REST Framework (DRF)

### Authentication
- JSON Web Token (JWT)

### Database
- SQLite

## 📂 Project Structure

```
Frontend/
├── HTML
├── CSS
└── JavaScript

Backend/
├── Django
├── Django REST Framework
├── JWT Authentication
├── User Model
└── Task Model
```

## 👤 Authentication

The application uses **JWT (JSON Web Token)** for secure authentication.

After a successful login, users receive an access token that is used to authenticate requests to protected API endpoints.

## 📌 User Model

The project uses Django's built-in **User** model for authentication and user management.

Each authenticated user has access only to their own tasks.


## 🔧 API Endpoints

- User Registration
- User Login (JWT)
- Create Task
- Retrieve User Tasks
- Delete Task


## 🎯 Project Goal

This project was initially developed to practice **Full-Stack Web Development** by integrating a responsive frontend with a secure RESTful backend using **Django REST Framework** and **JWT Authentication**.

It also serves as a foundation for applying modern **DevOps** practices. The next phase of the project focuses on containerization, CI/CD, Kubernetes, Infrastructure as Code, and deploying the application to **AWS** to simulate a real-world production environment.

**Made with ❤️ by Yousef Elzahaby**
