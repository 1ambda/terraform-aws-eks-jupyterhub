resource "aws_security_group" "bastion" {
  name = "${local.bastion_public_prefix}-${lower(var.environment)}"

  tags = {
    Terraform   = "true"
    Environment = var.environment

    Name = "${local.bastion_public_prefix}-${lower(var.environment)}"
  }

  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "bastion_allow_to_all" {
  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "bastion_allow_ssh_from_all" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  cidr_blocks = [
    "0.0.0.0/0", // testing purpose. DO NOT USE in production.
  ]

  security_group_id = aws_security_group.bastion.id

  description = "SSH (ALL)"
}

##
## Security Rules: From Bastion
##

resource "aws_security_group_rule" "efs_jupyter_shared_allow_efs_from_bastion" {
  type      = "ingress"
  from_port = local.port.efs
  to_port   = local.port.efs
  protocol  = "tcp"

  source_security_group_id = aws_security_group.bastion.id
  security_group_id = var.sg_id_efs_jupyter_shared

  description = "Bastion (Public)"
}

