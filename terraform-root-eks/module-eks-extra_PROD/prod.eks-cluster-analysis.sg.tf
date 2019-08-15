##
## Security Group
##
resource "aws_security_group" "eks_cluster_analysis" {
  vpc_id = var.vpc_id
  name = "eks-cluster-${var.project_analysis}-${var.environment}"

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Project = var.project_analysis

    Name = "eks-cluster-${var.project_analysis}-${lower(var.environment)}"
  }
}

output "sg_id_eks_cluster_analysis" {
  value = aws_security_group.eks_cluster_analysis.id
}

##
## Security Rule - Outbound
##

resource "aws_security_group_rule" "eks_cluster_analysis_allow_to_all" {
  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = aws_security_group.eks_cluster_analysis.id
}

##
## Security Rule - Inbound
##

resource "aws_security_group_rule" "eks_cluster_analysis_allow_https_from_worker" {
  type      = "ingress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  source_security_group_id = aws_security_group.eks_worker_analysis.id
  security_group_id = aws_security_group.eks_cluster_analysis.id

  description = "HTTPS (${aws_security_group.eks_worker_analysis.name})"
}

