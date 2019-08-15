locals {
  instance_name_bastion_01_prefix = local.bastion_public_prefix
  instance_name_bastion_01_index  = "01"
  instance_name_bastion_01     = "${local.instance_name_bastion_01_prefix}-${local.instance_name_bastion_01_index}"
}

resource "aws_instance" "bastion_01" {
  ami = data.aws_ami.amazon_linux_2.id

  lifecycle {
    create_before_destroy = false

    ignore_changes = [
      "ami",
      "user_data",
    ]
  }

  instance_type = "t3.small"
  subnet_id     = var.subnet_id_public_2a

  vpc_security_group_ids = [
    aws_security_group.bastion.id,
  ]

  associate_public_ip_address = true

  key_name             = var.keypair_name
  iam_instance_profile = var.instance_profile_name_bastion

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "50"
    delete_on_termination = true # use `false` for produciton :)
  }

  user_data = data.template_cloudinit_config.bastion_user_data.rendered

  tags = {
    Terraform   = "true"
    Environment = var.environment

    Name = "${local.instance_name_bastion_01}-${var.environment}"
  }
}

output "bastion_public_ip" {
  value = aws_instance.bastion_01.public_ip
}

output "bastion_public_dns" {
  value = aws_instance.bastion_01.public_dns
}
