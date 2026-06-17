# Exercise 01 – EKS Application Deployment via GitOps

## Objective

Deploy a new microservice called `payment-service` to Amazon EKS using GitOps principles.

## Architecture

GitHub
↓
GitHub Actions
↓
Amazon ECR
↓
ArgoCD
↓
Amazon EKS
↓
ALB Ingress
↓
Users

AWS Secrets Manager
↓
IRSA
↓
payment-service

Prometheus
↓
Grafana

## Technologies Used

* Amazon EKS
* Amazon ECR
* GitHub Actions
* ArgoCD
* Helm
* AWS Secrets Manager
* IRSA
* ALB Ingress Controller
* Prometheus
* Grafana

## Status

* [ ] EKS Cluster Created
* [ ] ArgoCD Installed
* [ ] payment-service Dockerized
* [ ] Image Pushed to ECR
* [ ] Helm Chart Created
* [ ] ArgoCD Auto-Sync Configured
* [ ] Secrets Manager Integrated
* [ ] IRSA Configured
* [ ] ALB Ingress Configured
* [ ] Metrics Visible in Grafana
