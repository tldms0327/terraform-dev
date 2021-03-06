resource "aws_security_group" "cluster" {
  name        = local.cluster_name
  description = "Cluster communication with Worker Nodes"

  vpc_id = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = var.ip_family == "ipv6" ? ["::/0"] : null
  }

  tags = {
    "Name"                                      = local.cluster_name
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group_rule" "cluster_worker" {
  description              = "Allow workers to communicate with the cluster API Server"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.worker.id
  type                     = "ingress"
}
