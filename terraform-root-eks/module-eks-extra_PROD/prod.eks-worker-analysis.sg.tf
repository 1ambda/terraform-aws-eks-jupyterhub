##
## Security Group
##
resource "aws_security_group" "eks_worker_analysis" {
  vpc_id = var.vpc_id
  name = "eks-worker-${var.project_analysis}-${var.environment}"

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Project = var.project_analysis

    Name = "eks-worker-${var.project_analysis}-${lower(var.environment)}"
    "kubernetes.io/cluster/${var.project_analysis}-${var.environment}" = "owned"
  }
}

output "sg_id_eks_worker_analysis" {
  value = aws_security_group.eks_worker_analysis.id
}

resource "aws_security_group_rule" "eks_worker_analysis_allow_all_from_self" {
  type      = "ingress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  source_security_group_id = aws_security_group.eks_worker_analysis.id
  security_group_id = aws_security_group.eks_worker_analysis.id

  description = "SELF"
}

##
## Security Rule - Outbound
##

resource "aws_security_group_rule" "eks_worker_analysis_allow_to_all" {
  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = aws_security_group.eks_worker_analysis.id
}

##
## Security Rule - Inbound
##

resource "aws_security_group_rule" "eks_worker_analysis_allow_https_from_cluster" {
  type      = "ingress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  source_security_group_id = aws_security_group.eks_cluster_analysis.id
  security_group_id = aws_security_group.eks_worker_analysis.id

  description = "HTTPS (${aws_security_group.eks_cluster_analysis.name})"
}

resource "aws_security_group_rule" "eks_worker_analysis_allow_tcp_from_cluster" {
  type      = "ingress"
  from_port = 22
  to_port   = 65535
  protocol  = "tcp"

  source_security_group_id = aws_security_group.eks_cluster_analysis.id
  security_group_id = aws_security_group.eks_worker_analysis.id

  description = "TCP (${aws_security_group.eks_cluster_analysis.name})"
}

##
## Security Rule - From EKS Worker
##

resource "aws_security_group_rule" "efs_jupyter_shared_allow_efs_from_eks_worker" {
  type      = "ingress"
  from_port = local.port.efs
  to_port   = local.port.efs
  protocol  = "tcp"

  source_security_group_id = aws_security_group.eks_worker_analysis.id
  security_group_id = var.sg_id_efs_jupyter_shared

  description = "eks-worker-analysis"
}

