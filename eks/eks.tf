module "eks" {
  source = "../modules/eks"

  cluster_name = var.cluster_name
  vpc_id       = local.vpc_id
  subnet_ids   = local.private_subnets

  kubernetes_version = var.kubernetes_version

  endpoint_public_access = true
  ip_family              = ""

  iam_group = local.iam_group
  iam_roles = local.iam_roles

  worker_policies   = local.worker_policies
  worker_source_sgs = local.worker_source_sgs

  tags = local.tags
}
