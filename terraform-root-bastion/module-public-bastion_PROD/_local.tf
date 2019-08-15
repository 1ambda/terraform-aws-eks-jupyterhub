locals {
  ebs_root_device_link       = "/dev/nvme0n1p1"

  bastion_public_prefix = "bastion-public"

  port = {
    efs = 2049
  }
}