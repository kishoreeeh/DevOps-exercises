Exercise 19: Helm Chart Engineering

Objective:
Build a reusable Helm Chart that supports replicas, resources, ConfigMaps, Secrets, Ingress, and Autoscaling. The chart should work across Dev, QA, and Prod environments using different values files.

--------------------------------------------------

Step 1: Create Helm Chart

Created a new Helm Chart using:

helm create myapp-chart

This generated the default Helm chart structure.

--------------------------------------------------

Step 2: Clean Up Generated Files

Removed unnecessary files:

- NOTES.txt
- httproute.yaml
- serviceaccount.yaml
- tests/

Kept only:

- deployment.yaml
- service.yaml
- configmap.yaml
- secret.yaml
- ingress.yaml
- hpa.yaml
- _helpers.tpl

--------------------------------------------------

Step 3: Create Values Files

Created:

- values.yaml
- values-dev.yaml
- values-qa.yaml
- values-prod.yaml

Purpose:

values.yaml:
Default configuration shared across all environments.

values-dev.yaml:
Development environment configuration.

values-qa.yaml:
QA environment configuration.

values-prod.yaml:
Production environment configuration.

--------------------------------------------------

Step 4: Configure Default Values

Added configurations for:

- replicaCount
- image
- service
- resources
- config
- secret
- ingress
- autoscaling

This file acts as the base configuration for the chart.

--------------------------------------------------

Step 5: Configure Dev Environment

values-dev.yaml

Configuration:

- replicaCount = 1
- APP_ENV = dev
- Autoscaling Disabled

Purpose:

Development environment requires fewer resources and no autoscaling.

--------------------------------------------------

Step 6: Configure QA Environment

values-qa.yaml

Configuration:

- replicaCount = 2
- APP_ENV = qa
- Autoscaling Enabled
- Max Replicas = 4

Purpose:

QA environment simulates production behavior while keeping resource usage moderate.

--------------------------------------------------

Step 7: Configure Production Environment

values-prod.yaml

Configuration:

- replicaCount = 4
- APP_ENV = prod
- Autoscaling Enabled
- Max Replicas = 10

Purpose:

Production environment requires high availability and scalability.

--------------------------------------------------

Step 8: Create Deployment Template

Created:

templates/deployment.yaml

Features:

- Dynamic replica count
- Dynamic image configuration
- Resource requests
- Resource limits
- ConfigMap integration
- Secret integration

The deployment automatically picks values from the selected values file.

--------------------------------------------------

Step 9: Create Service Template

Created:

templates/service.yaml

Features:

- Dynamic service type
- Dynamic service port

Provides internal Kubernetes networking for the application.

--------------------------------------------------

Step 10: Create ConfigMap Template

Created:

templates/configmap.yaml

Stores:

APP_ENV

Examples:

APP_ENV=dev
APP_ENV=qa
APP_ENV=prod

Depending on the selected environment.

--------------------------------------------------

Step 11: Create Secret Template

Created:

templates/secret.yaml

Stores:

- username
- password

The deployment accesses these values securely through environment variables.

--------------------------------------------------

Step 12: Create Ingress Template

Created:

templates/ingress.yaml

Features:

- Optional creation
- Host-based routing
- Environment-specific deployment

Controlled using:

ingress.enabled

If false:
Ingress is not created.

If true:
Ingress is automatically created.

--------------------------------------------------

Step 13: Create HPA Template

Created:

templates/hpa.yaml

Supports:

- minReplicas
- maxReplicas
- CPU utilization threshold

Example:

minReplicas: 2
maxReplicas: 5
targetCPUUtilizationPercentage: 70

Purpose:

Automatically scales application pods based on CPU usage.

--------------------------------------------------

Step 14: Validate Helm Chart

Executed:

helm lint .

Result:

1 chart(s) linted, 0 chart(s) failed

Meaning:

The Helm chart syntax and structure are valid.

--------------------------------------------------

Step 15: Render Kubernetes Manifests

Executed:

helm template myapp .

Generated:

- Secret
- ConfigMap
- Service
- Deployment
- HorizontalPodAutoscaler

This confirms the chart renders successfully.

--------------------------------------------------

Step 16: Test Dev Environment

Executed:

helm template myapp . -f values-dev.yaml

Result:

- APP_ENV = dev
- Replicas = 1
- HPA Disabled

--------------------------------------------------

Step 17: Test QA Environment

Executed:

helm template myapp . -f values-qa.yaml

Result:

- APP_ENV = qa
- Replicas = 2
- HPA Enabled
- Max Replicas = 4

--------------------------------------------------

Step 18: Test Production Environment

Executed:

helm template myapp . -f values-prod.yaml

Result:

- APP_ENV = prod
- Replicas = 4
- HPA Enabled
- Max Replicas = 10

--------------------------------------------------

Final Outcome

Successfully created a reusable Helm Chart that supports:

✓ Replicas
✓ Resources
✓ ConfigMaps
✓ Secrets
✓ Ingress
✓ Autoscaling
✓ Dev Environment
✓ QA Environment
✓ Production Environment

Benefits:

- Reusable Kubernetes deployments
- Reduced YAML duplication
- Environment-specific configurations
- Easier maintenance
- Scalable deployment model

Conclusion:

This exercise demonstrates Helm Chart Engineering by creating reusable Kubernetes templates and deploying them using environment-specific values files. Helm enables consistent, scalable, and maintainable application deployments across Dev, QA, and Production environments.
