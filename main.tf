provider "aws" {
  region = "us-west-2"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster" "cluster" {
  name = "devops-test-cluster"
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.aws_eks_cluster.cluster.name
}

resource "kubernetes_manifest" "app1_deployment" {
  manifest = yamldecode(file("${path.module}/kubernetes/app1-deployment.yaml"))
}

resource "kubernetes_manifest" "app1_service" {
  manifest = yamldecode(file("${path.module}/kubernetes/app1-service.yaml"))
}

resource "kubernetes_manifest" "app2_deployment" {
  manifest = yamldecode(file("${path.module}/kubernetes/app2-deployment.yaml"))
}

resource "kubernetes_manifest" "app2_service" {
  manifest = yamldecode(file("${path.module}/kubernetes/app2-service.yaml"))
}