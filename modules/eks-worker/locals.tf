locals {
  subgroup = var.subname == "" ? var.name : format("%s-%s", var.name, var.subname)
  fullname = var.vername == "" ? local.subgroup : format("%s-%s", local.subgroup, var.vername)

  worker_name = format("%s-%s", var.cluster_name, local.fullname)
}

locals {
  node_labels_map = merge(
    {
      "group"         = var.name
      "subgroup"      = local.subgroup
      "instancegroup" = local.fullname
    },
    var.node_labels,
  )

  #   user_data = <<EOF
  # #!/bin/bash -xe
  # mkdir -p ~/.docker && echo '${data.aws_ssm_parameter.docker_config.value}' > ~/.docker/config.json
  # mkdir -p /var/lib/kubelet && echo '${data.aws_ssm_parameter.docker_config.value}' > /var/lib/kubelet/config.json
  # EOF
}

locals {
  tags = merge(
    var.tags,
    {
      "Name"                                      = local.worker_name
      "KubernetesCluster"                         = var.cluster_name
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
      #   "krmt.io/group"                               = var.name
      #   "krmt.io/subgroup"                            = local.subgroup
      #   "krmt.io/instancegroup"                       = local.fullname
    },
  )
}
