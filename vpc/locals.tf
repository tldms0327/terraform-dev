locals {
  tags = {
    Environment = "dev"
  }

  eks_tags = {
    "kubernetes.io/cluster/eks-demo" = "shared"
  }
}
