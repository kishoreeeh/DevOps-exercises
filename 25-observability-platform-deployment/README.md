# Exercise 25: Observability Platform Deployment

## Objective

Deploy a complete Observability Platform on Kubernetes capable of collecting:

- Metrics
- Logs
- Traces

and visualize them using Grafana dashboards.

---

## Architecture

```
Application / Kubernetes Cluster
            |
            |
    -------------------
    |        |        |
 Metrics    Logs    Traces
    |        |        |
Prometheus  Loki   Tempo
    \        |       /
     \       |      /
          Grafana
```

---

## Components Used

| Component | Purpose |
|------------|----------|
| Prometheus | Metrics Collection |
| Grafana | Visualization & Dashboards |
| Loki | Log Aggregation |
| Alloy | Telemetry Collection |
| Tempo | Distributed Tracing |
| Kubernetes (EKS) | Container Orchestration |

---

## Environment

- AWS EKS
- Region: us-east-1
- Kubernetes Version: 1.34
- Helm: v3
- Grafana
- Prometheus
- Loki
- Alloy
- Tempo

---

## Cluster Creation

```bash
eksctl create cluster \
--name observability-lab \
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

## Namespace Creation

```bash
kubectl create namespace observability
```

---

## Install Grafana

```bash
helm install grafana grafana/grafana \
-n observability
```

Expose service:

```bash
kubectl expose deployment grafana \
--type=LoadBalancer \
--port=80 \
--target-port=3000 \
-n observability
```

---

## Install Prometheus

```bash
helm install prometheus prometheus-community/prometheus \
-n observability
```

Verify:

```bash
kubectl get pods -n observability
```

---

## Install Tempo

```bash
helm install tempo grafana/tempo \
-n observability
```

---

## Install Alloy

```bash
helm install alloy grafana/alloy \
-n observability
```

---

## Install Loki Stack

```bash
helm install loki-stack grafana/loki-stack \
-n observability
```

Verify:

```bash
kubectl get pods -n observability
```

---

## Configure Grafana Data Sources

### Prometheus

URL:

```text
http://prometheus-server
```

Status:

```text
Successfully queried the Prometheus API
```

### Loki

URL:

```text
http://loki-stack:3100
```

Status:

```text
Data source is working
```

### Tempo

URL:

```text
http://tempo:3100
```

Status:

```text
Data source is working
```

---

## Metrics Verification

Prometheus query:

```promql
prometheus_http_requests_total
```

Result:

Metrics successfully collected.

---

## Logs Verification

Loki query:

```logql
{job=~".+"}
```

Result:

Logs successfully collected from Kubernetes pods.

---

## Traces Verification

Tempo datasource configured and connected successfully.

---

# Dashboards Created

## CPU Usage

```promql
100 - (avg by(instance)(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

---

## Memory Usage

```promql
(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100
```

---

## Request Rate

```promql
sum(increase(prometheus_http_requests_total[5m]))
```

---

## Error Rate

```promql
sum(rate(prometheus_http_requests_total{code!="200"}[5m]))
```

---

# Screenshots

Store screenshots in:

```
screenshots/
```

Recommended screenshots:

1. EKS Nodes
2. Grafana Home
3. Prometheus Data Source
4. Loki Data Source
5. Tempo Data Source
6. Node Exporter Dashboard
7. Request Rate Dashboard
8. Error Rate Dashboard
9. Kubernetes Pods

---

# Validation

Verify all components:

```bash	
kubectl get pods -n observability
```

Expected:

- Grafana Running
- Prometheus Running
- Loki Running
- Alloy Running
- Tempo Running

---

# Outcome

Successfully deployed a complete Observability Platform on Kubernetes using:

- Prometheus
- Grafana
- Loki
- Alloy
- Tempo

Collected:

- Metrics ✅
- Logs ✅
- Traces ✅

Created Dashboards:

- CPU Usage ✅
- Memory Usage ✅
- Request Rate ✅
- Error Rate ✅

Exercise 25 Completed Successfully.
