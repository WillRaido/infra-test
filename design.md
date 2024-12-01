
# **Design Document: AWS EKS Application Deployment**

## **Overview**
This document outlines the design and architecture for deploying two containerized applications (`App1` and `App2`) on an AWS Elastic Kubernetes Service (EKS) cluster. The deployment uses **Terraform** for infrastructure provisioning, **Docker** for containerization, and **Kubernetes** for orchestration.

---

## **Architecture**
The architecture includes:
1. **AWS EKS**: A managed Kubernetes cluster to orchestrate and manage containerized applications.
2. **Kubernetes Deployments**: `App1` and `App2` are deployed as separate workloads.
3. **Kubernetes Services**: LoadBalancer services route traffic to the respective deployments.
4. **Container Registry**: Docker Hub or Amazon ECR is used to store the container images for the applications.

### **Diagram**
![Architecture Diagram](images/architecture-diagram.png)

---

## **Design Decisions**
### **1. Infrastructure as Code (IaC) with Terraform**
- Terraform is used for consistency and repeatability in provisioning infrastructure.
- The configuration includes EKS cluster creation, node group provisioning, and Kubernetes manifests management.

### **2. Containerization with Docker**
- Docker is used to package the applications into containers, ensuring portability and consistency across environments.

### **3. Kubernetes for Orchestration**
- Kubernetes deployments manage application replicas for high availability.
- Services provide stable endpoints and load balancing.

### **4. Automation with GitHub Actions**
- CI/CD pipelines automate Terraform execution, ensuring infrastructure changes are applied seamlessly.

---

## **Project Structure**
```plaintext
infra-test/
├── kubernetes/
│   ├── app1-deployment.yaml       # Manifest for App1 Deployment
│   ├── app1-service.yaml          # Manifest for App1 Service
│   ├── app2-deployment.yaml       # Manifest for App2 Deployment
│   ├── app2-service.yaml          # Manifest for App2 Service
├── main.tf                        # Terraform configuration
├── variables.tf                   # Terraform variables
├── outputs.tf                     # Terraform outputs
├── .github/
│   ├── workflows/
│       ├── deploy.yml             # GitHub Actions workflow
├── design.md                      # This design document
```

---

## **Deployment Workflow**
1. **Containerization**: Applications are containerized with Docker and pushed to a container registry (Docker Hub or Amazon ECR).
2. **Terraform Execution**:
   - **Cluster Creation**: EKS cluster and node groups are provisioned.
   - **Application Deployment**: Kubernetes manifests are applied to deploy applications.
3. **Automation**: GitHub Actions automates the deployment process.

---

## **Key Considerations**
### **1. Scalability**
- Kubernetes deployments can scale horizontally based on application traffic.
- Node groups in EKS can auto-scale based on demand.

### **2. High Availability**
- EKS ensures application availability with replicas managed by Kubernetes deployments.
- LoadBalancer services distribute traffic across healthy pods.

### **3. Security**
- IAM roles for EKS are configured to restrict access.
- Secrets are managed securely within Kubernetes.

### **4. Monitoring**
- AWS CloudWatch and Kubernetes metrics are used for monitoring cluster health and application performance.

---

## **Repositories**
- [App1 Repository](https://github.com/WillRaido/App1-test): Source code and containerization for App1.
- [App2 Repository](https://github.com/WillRaido/App2-test): Source code and containerization for App2.

---

## **Future Improvements**
1. **CI/CD for Applications**:
   - Add workflows for building and pushing Docker images for `App1` and `App2`.
2. **Monitoring Enhancements**:
   - Integrate Prometheus and Grafana for more detailed monitoring.
3. **Multi-Environment Support**:
   - Extend Terraform to support staging and production environments.

---

## **Conclusion**
This design ensures a scalable, highly available, and secure deployment for containerized applications on AWS EKS. By leveraging Terraform and Kubernetes, it provides a robust infrastructure for modern application deployment.

