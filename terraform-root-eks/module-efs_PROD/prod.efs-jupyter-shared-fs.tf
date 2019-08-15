resource "aws_efs_file_system" "jupyter_shared" {
  creation_token = "${local.efs_prefix_jupyter_shared}-${var.environment}"

  performance_mode = "generalPurpose"
  throughput_mode = "bursting"

  tags = {
    Name = "${local.efs_prefix_jupyter_shared}-${var.environment}"

    Environment = var.environment
    Terraform = "true"
  }
}

resource "aws_efs_mount_target" "jupyter_shared_2a" {
  file_system_id = aws_efs_file_system.jupyter_shared.id
  subnet_id = var.subnet_id_private_2a
  security_groups = [
    aws_security_group.efs_jupyter_shared.id,
  ]
}

resource "aws_efs_mount_target" "jupyter_shared_2b" {
  file_system_id = aws_efs_file_system.jupyter_shared.id
  subnet_id = var.subnet_id_private_2b
  security_groups = [
    aws_security_group.efs_jupyter_shared.id,
  ]
}

resource "aws_efs_mount_target" "jupyter_shared_2c" {
  file_system_id = aws_efs_file_system.jupyter_shared.id
  subnet_id = var.subnet_id_private_2c
  security_groups = [
    aws_security_group.efs_jupyter_shared.id,
  ]
}

output "efs_dns_jupyter_shared" {
  value = aws_efs_file_system.jupyter_shared.dns_name
}
