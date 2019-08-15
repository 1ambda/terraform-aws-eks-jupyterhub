variable "environment" {}

variable "instance_profile_name_bastion" {}
variable "keypair_name" {}

variable "dns_efs_jupyter_shared" {}

variable "sg_id_efs_jupyter_shared" {}
variable "sg_id_eks_cluster_analysis" {}
variable "sg_id_eks_worker_analysis" {}

variable "vpc_id" {}
variable "subnet_id_public_2a" {}
variable "subnet_id_public_2c" {}
variable "subnet_id_public_2b" {}
variable "subnet_id_private_2a" {}
variable "subnet_id_private_2c" {}
variable "subnet_id_private_2b" {}

