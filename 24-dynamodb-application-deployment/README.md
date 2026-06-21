# Exercise 24: DynamoDB Application Deployment

## Objective

Deploy an application that performs DynamoDB operations using IRSA (IAM Roles for Service Accounts) without AWS Access Keys.

## Requirements

Implemented:

* Read Customer
* Write Customer
* Update Customer

Constraints:

* No AWS Access Keys
* Only IRSA

## Architecture

Application Pod
↓
Kubernetes Service Account
↓
IAM Role (IRSA)
↓
DynamoDB Customers Table

## Components Used

* Amazon EKS
* Amazon DynamoDB
* Amazon ECR
* IAM Roles for Service Accounts (IRSA)
* Docker
* Kubernetes

## Implementation Steps

### 1. Created DynamoDB Table

Table Name:

Customers

### 2. Created IAM Policy

Permissions:

* dynamodb:GetItem
* dynamodb:PutItem
* dynamodb:UpdateItem

### 3. Configured OIDC Provider

OIDC provider associated with EKS cluster.

### 4. Created IRSA Service Account

Service Account:

dynamodb-app

Annotated with IAM Role.

### 5. Built and Pushed Docker Image

Repository:

dynamodb-app

Image Tag:

v1

### 6. Deployed Application to EKS

Deployment:

dynamodb-app

Replicas:

2

### 7. Exposed Application

Service:

dynamodb-app-service

Type:

LoadBalancer

## Verification

### Write Customer

POST /customer

Customer successfully inserted into DynamoDB.

### Read Customer

GET /customer/{id}

Customer successfully retrieved from DynamoDB.

### Update Customer

PUT /customer/{id}

Customer successfully updated in DynamoDB.

## IRSA Verification

Verified that the application used:

* Kubernetes Service Account
* IAM Role

No AWS Access Keys were used.

## Outcome

Successfully deployed a DynamoDB-enabled application on Amazon EKS using IRSA. The application performed Create, Read and Update operations on DynamoDB without storing AWS credentials inside the application.
