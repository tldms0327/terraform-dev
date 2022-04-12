resource "aws_launch_template" "worker" {
  name_prefix = format("%s-", local.worker_name)

  key_name = var.key_name

  ebs_optimized = var.ebs_optimized

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_type           = var.volume_type
      volume_size           = var.volume_size
      delete_on_termination = true
    }
  }

  monitoring {
    enabled = var.enable_monitoring
  }

  network_interfaces {
    delete_on_termination       = true
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = var.security_groups
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = local.tags
  }

  tag_specifications {
    resource_type = "volume"

    tags = local.tags
  }

  tags = local.tags
}
