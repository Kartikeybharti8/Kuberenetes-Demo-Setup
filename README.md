# Kuberenetes-Demo-Setup
#1. Steps for setting Up Terraform:
- Download terraform cli
- Authenticate Terraform with Azure run:
  az login // login with credentials
- With 'main.tf' file to define Azure resources perform below steps to add resources:
  terraform init
  terraform apply

#2. Containerizing the Static Web Application
- Build and push the Docker image:
  docker build -t demoContainerRegistry.azurecr.io/static-web-app:latest .
  docker push demoContainerRegistry.azurecr.io/static-web-app:latest

#3. Deploy the files to the Kubernetes cluster:
- Deploy apps deployement and service using manifest files.
  kubectl apply -f demo-app-deployment.yaml
  kubectl apply -f demo-app-service.yaml

#4 Access the Static Web App:
- Once service is deployed retrieve the external IP:
  kubectl get service static-webapp-service
- Use  the external IP on browser to access the web app.

#5 Steps to Set Up Logging and Monitoring with Prometheus:
1. Install Prometheus:
- Namespace for Prometheus:
    kubectl create namespace monitoring

- Install Prometheus:
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    helm install prometheus prometheus-community/prometheus --namespace monitoring

- Verifying installation:
    kubectl get pods -n monitoring

- Ensure the 'node-exporter' component is running by verifying its deployment:
    kubectl get pods -n monitoring | grep node-exporter

2. Configure Prometheus:
- Expose Prometheus via a LoadBalancer for external access:
    kubectl edit svc prometheus-server -n monitoring
- Manually Change the type to LoadBalancer.

- Get the external IP:
    kubectl get svc prometheus-server -n monitoring
- Access Prometheus by external IP.

3. Set Up Node Exporter:
- Ensure Node Exporter is deployed as part of the Prometheus setup to collect metrics.

4. For Metrics:
- Access the Prometheus dashboard to explore metrics such as CPU, memory, and network usage.