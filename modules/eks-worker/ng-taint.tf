resource "aws_eks_node_group" "worker-taint" {
  count = var.enable_taints ? 1 : 0

  node_group_name_prefix = format("%s-", local.worker_name)

  cluster_name  = var.cluster_name
  node_role_arn = var.node_role_arn
  subnet_ids    = var.subnet_ids

  launch_template {
    id      = aws_launch_template.worker.id
    version = aws_launch_template.worker.latest_version
  }

  capacity_type  = var.enable_spot ? "SPOT" : "ON_DEMAND"
  ami_type       = var.ami_type
  instance_types = var.instance_types

  labels = local.node_labels_map

  taint {
    effect = "NO_SCHEDULE"
    key    = "group"
    value  = var.name
  }

  scaling_config {
    desired_size = var.min
    max_size     = var.max
    min_size     = var.min
  }

  update_config {
    max_unavailable_percentage = var.max_unavailable_percentage
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = local.tags
}
