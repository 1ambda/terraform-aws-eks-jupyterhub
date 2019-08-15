##
## Security Group
##
resource "aws_security_group" "eks_public_lb_analysis" {
  vpc_id = var.vpc_id
  name = "eks-public-lb-${var.project_analysis}-${var.environment}"

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Project = var.project_analysis

    Name = "eks-public-lb-${lower(var.environment)}"
  }
}

output "sg_id_eks_public_lb_analysis" {
  value = aws_security_group.eks_public_lb_analysis.id
}

##
## Security Rule - Outbound
##

resource "aws_security_group_rule" "eks_public_lb_analysis_allow_to_all" {
  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = aws_security_group.eks_public_lb_analysis.id
}

##
## Security Rule - Inbound
##

resource "aws_security_group_rule" "eks_worker_analysis_allow_https_from_all" {
  type      = "ingress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
  security_group_id = aws_security_group.eks_public_lb_analysis.id

  description = "HTTPS (ALL)"
}

resource "aws_security_group_rule" "eks_worker_analysis_allow_http_from_all" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
  security_group_id = aws_security_group.eks_public_lb_analysis.id

  description = "HTTP (ALL)"
}

##
## Security Rule - From EKS Public LB Analysis
##

resource "aws_security_group_rule" "eks_worker_analysis_allow_all_from_eks_public_lb_analysis" {
  type      = "ingress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"

  source_security_group_id = aws_security_group.eks_public_lb_analysis.id
  security_group_id = aws_security_group.eks_worker_analysis.id

  description = "ALL (eks-public-lb-analysis)"
}

