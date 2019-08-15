module "bastion_public_production" {
  source = "./module-public-bastion_PROD"

  environment = local.env_production_lower

  instance_profile_name_bastion = local.instance_profile_name_basic
  keypair_name = local.key_pair_name

  vpc_id               = local.vpc_prod_id
  subnet_id_private_2a = local.vpc_prod_private_subnet_id_a
  subnet_id_private_2b = local.vpc_prod_private_subnet_id_b
  subnet_id_private_2c = local.vpc_prod_private_subnet_id_c
  subnet_id_public_2a = local.vpc_prod_public_subnet_id_a
  subnet_id_public_2b = local.vpc_prod_public_subnet_id_b
  subnet_id_public_2c = local.vpc_prod_public_subnet_id_c

  dns_efs_jupyter_shared = data.terraform_remote_state.eks.outputs.efs_jupyter_shared__dns

  sg_id_efs_jupyter_shared = data.terraform_remote_state.eks.outputs.efs_jupyter_shared__sg_id
  sg_id_eks_cluster_analysis = data.terraform_remote_state.eks.outputs.eks_analysis_production__sg_id_cluster
  sg_id_eks_worker_analysis = data.terraform_remote_state.eks.outputs.eks_analysis_production__sg_id_worker
}

