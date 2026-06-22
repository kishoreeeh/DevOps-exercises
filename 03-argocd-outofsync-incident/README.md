# Exercise 3: ArgoCD OutOfSync Production Incident

## Objective

Simulate and investigate an ArgoCD production incident where:

* ArgoCD reports **OutOfSync**
* Application Health remains **Healthy**
* Git and Cluster configurations drift apart

---

# Architecture

GitHub Repository
↓
ArgoCD
↓
Kubernetes Deployment (payment-service)

---

# Environment

* AWS EKS
* Kubernetes
* ArgoCD
* GitHub
* kubectl
* ArgoCD CLI

---

# Project Structure

```text
03-argocd-outofsync-incident/
├── docs
├── manifests
│   ├── deployment.yaml
│   └── service.yaml
└── screenshots
```

---

# Deployment Manifest

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: payment-service
spec:
  replicas: 3
  selector:
    matchLabels:
      app: payment-service
  template:
    metadata:
      labels:
        app: payment-service
    spec:
      containers:
      - name: nginx
        image: nginx:latest
```

---

# Service Manifest

```yaml
apiVersion: v1
kind: Service
metadata:
  name: payment-service
spec:
  selector:
    app: payment-service
  ports:
  - port: 80
    targetPort: 80
```

---

# Create EKS Cluster

```bash
eksctl create cluster \
--name argocd-lab \
--region us-east-1 \
--nodegroup-name workers \
--nodes 2 \
--node-type t3.small
```

Verify:

```bash
kubectl get nodes
```

---

# Install ArgoCD

Create namespace:

```bash
kubectl create namespace argocd
```

Install:

```bash
kubectl apply -n argocd \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Verify:

```bash
kubectl get pods -n argocd
```

---

# Expose ArgoCD

```bash
kubectl patch svc argocd-server \
-n argocd \
-p '{"spec":{"type":"LoadBalancer"}}'
```

Get ELB URL:

```bash
kubectl get svc -n argocd
```

---

# Login To ArgoCD

Get password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d
```

Login:

```bash
argocd login <ARGOCD-ELB>
```

---

# Create Application

```bash
argocd app create payment-service \
--repo https://github.com/ajayk1718/DEVOPS_EXC.git \
--path 03-argocd-outofsync-incident/manifests \
--dest-server https://kubernetes.default.svc \
--dest-namespace default
```

---

# Initial Sync

```bash
argocd app sync payment-service
```

Verify:

```bash
argocd app get payment-service
```

Expected:

```text
Sync Status : Synced
Health      : Healthy
```

---

# Incident Creation

Manual change in cluster:

```bash
kubectl scale deployment payment-service \
--replicas=5
```

Verify:

```bash
kubectl get deploy payment-service
```

Output:

```text
REPLICAS = 5
```

---

# Incident Symptoms

Check ArgoCD:

```bash
argocd app get payment-service
```

Observed:

```text
Sync Status : OutOfSync
Health      : Healthy
```

---

# Investigation

Compare Git and Cluster:

```bash
argocd app diff payment-service
```

Result:

```text
Git:
replicas: 3

Cluster:
replicas: 5
```

---

# Root Cause

A manual change was performed directly on the Kubernetes cluster using:

```bash
kubectl scale deployment payment-service --replicas=5
```

This caused configuration drift between Git and the live cluster.

---

# Resolution

Restore desired state:

```bash
argocd app sync payment-service
```

Verify:

```bash
kubectl get deploy payment-service
```

Expected:

```text
REPLICAS = 3
```

Check ArgoCD:

```bash
argocd app get payment-service
```

Expected:

```text
Sync Status : Synced
Health      : Healthy
```

---

# Prevention

Enable automated sync:

```yaml
syncPolicy:
  automated:
    prune: true
    selfHeal: true
```

Additional Controls:

* Enforce GitOps workflow
* Restrict direct kubectl access using RBAC
* Enable audit logging
* Require pull requests for production changes

---

# Outcome

Successfully reproduced a real-world ArgoCD GitOps drift incident.

Achievements:

* Installed ArgoCD
* Connected GitHub repository
* Deployed application through GitOps
* Created configuration drift
* Investigated OutOfSync status
* Identified root cause
* Restored desired state
* Documented prevention strategy

Exercise 3 Completed Successfully.
