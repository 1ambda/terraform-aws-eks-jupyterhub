resource "aws_security_group" "efs_jupyter_shared" {
  name = "efs-${local.efs_prefix_jupyter_shared}-${lower(var.environment)}"

  tags = {
    Terraform   = "true"
    Environment = var.environment

    Name = "efs-${local.efs_prefix_jupyter_shared}-${lower(var.environment)}"
  }

  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "efs_jupyter_shared_allow_to_all" {
  type      = "egress"
  from_port = -1
  to_port   = -1
  protocol  = "-1"

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = aws_security_group.efs_jupyter_shared.id
}

output "sg_id_efs_jupyter_shared" {
  value = aws_security_group.efs_jupyter_shared.id
}
