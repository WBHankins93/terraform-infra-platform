##########################################
# Provider Configuration
##########################################

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_certificate)
    token                  = var.kube_token
  }
}

##########################################
# Helm Release: Cluster Autoscaler
##########################################

resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  namespace  = "kube-system"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = "9.29.0"

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  depends_on = [var.depends_on_cluster]
}

##########################################
# Helm Release: ALB Controller
##########################################

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.7.1"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "region"
    value = var.aws_region
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = var.alb_service_account
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  depends_on = [var.depends_on_cluster]
}

##########################################
# Service Account: ALB Controller
##########################################

resource "kubernetes_service_account" "alb_controller_sa" {
  metadata {
    name      = var.alb_service_account
    namespace = var.namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = var.alb_iam_role_arn
    }

    labels = {
      "app.kubernetes.io/name" = "aws-load-balancer-controller"
    }
  }
}