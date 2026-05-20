# Echo API - Cloud-Native Deployment

This repository contains a production-grade CI/CD pipeline and Kubernetes orchestration for a Node.js Express application.

## 🚀 Getting Started

### 1. Prerequisites
Ensure you have the following installed:
- [Docker](https://www.docker.com/products/docker-desktop/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Git](https://git-scm.com/)

### 2. Installation
Clone the repository:
```bash
git clone https://github.com/AchiTsa/seip_assignment_1_2026.git
cd seip_assignment_1_2026
```

### 3. Containerization
The application is containerized using a production-optimized `Dockerfile`. You can build the image locally:
```bash
docker build -t echo-api:latest .
```

### 4. Kubernetes Orchestration (Minikube)
Follow these steps to deploy the application to a local Kubernetes cluster:

#### Start Minikube & Load Image
```bash
minikube start
minikube image load echo-api:latest
```

#### Apply Manifests
Apply all manifests in the `k8s/` directory:
```bash
kubectl apply -f k8s/
```

This will create:
- **ConfigMap**: Non-sensitive configuration (`WELCOME_MESSAGE`, `NODE_ENV`).
- **Secret**: Sensitive `API_SECRET_KEY` (Base64 encoded).
- **Deployment**: 3 replicas of the API with resource limits and health probes.
- **Service**: A ClusterIP service exposing the API on port 80 internally.

#### Verify Deployment
```bash
kubectl get all
kubectl get configmap,secret
```

### 5. Interaction
Since the service is of type `ClusterIP`, use port-forwarding to access it from your local machine:
```bash
kubectl port-forward service/echo-api-service 8080:80
```

Now you can interact with the endpoints:
- **Root**: `http://localhost:8080/` (Displays greeting from ConfigMap)
- **Secure Config**: `http://localhost:8080/secure-config` (Displays masked secret from Secret)
- **Health**: `http://localhost:8080/health` (Health check endpoint)

---

## 🧹 Cleanup & Restart

To stop everything and clean up your environment:

### 1. Delete Kubernetes Resources
```bash
kubectl delete -f k8s/
```

### 2. Stop Minikube
```bash
minikube stop
```

### 3. (Optional) Full Reset
If you want to start from a completely blank slate:
```bash
minikube delete
docker system prune -a  # Warning: Removes all unused docker images/containers
```

### 4. Fresh Restart
To start again after a cleanup:
```bash
docker build -t echo-api:latest .
minikube start
minikube image load echo-api:latest
kubectl apply -f k8s/
kubectl port-forward service/echo-api-service 8080:80
```

---
