module "workers" {
  source = "../modules/eks-worker"

  name = "workers"

  cluster_name = local.cluster_name

  node_role_arn   = local.worker_role_arn
  security_groups = local.worker_security_groups
  subnet_ids      = local.private_subnets

  key_name = var.key_name

  enable_taints = false
  enable_spot   = true

  ami_type       = "AL2_x86_64"
  instance_types = ["c6i.large"]

  volume_type = "gp3"
  volume_size = "30"

  min = 1
  max = 2

  tags = local.tags
}
