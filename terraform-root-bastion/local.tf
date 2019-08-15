locals {
  // you might refer iam roles using `data` (remote state, ...)
  iam_role_name_eks_cluster = "common-role-eks-cluster"
  iam_role_name_eks_worker  = "common-role-eks-worker"

  // you might refer vpc id using `data` (remote state, ...)
  vpc_prod_id = data.terraform_remote_state.vpc.outputs.vpc_production__vpc_id

  instance_profile_name_basic = "common-role-ec2-basic"
  key_pair_name = "aws_infra_root_key"

  vpc_prod_private_subnet_cidr_a = data.terraform_remote_state.vpc.outputs.vpc_production__private_subnet_cidr_a
  vpc_prod_private_subnet_cidr_b = data.terraform_remote_state.vpc.outputs.vpc_production__private_subnet_cidr_b
  vpc_prod_private_subnet_cidr_c = data.terraform_remote_state.vpc.outputs.vpc_production__private_subnet_cidr_c

  vpc_prod_private_subnets_cidr = [
    local.vpc_prod_private_subnet_cidr_a,
    local.vpc_prod_private_subnet_cidr_b,
    local.vpc_prod_private_subnet_cidr_c,
  ]

  vpc_prod_public_subnet_cidr_a = data.terraform_remote_state.vpc.outputs.vpc_production__public_subnet_cidr_a
  vpc_prod_public_subnet_cidr_b = data.terraform_remote_state.vpc.outputs.vpc_production__public_subnet_cidr_b
  vpc_prod_public_subnet_cidr_c = data.terraform_remote_state.vpc.outputs.vpc_production__public_subnet_cidr_a

  vpc_prod_public_subnets_cidr = [
    local.vpc_prod_public_subnet_cidr_a,
    local.vpc_prod_public_subnet_cidr_b,
    local.vpc_prod_public_subnet_cidr_c,
  ]

  vpc_prod_private_subnet_id_a = data.terraform_remote_state.vpc.outputs.vpc_production__private_subnet_id_a
  vpc_prod_private_subnet_id_b = data.terraform_remote_state.vpc.outputs.vpc_production__private_subnet_id_b
  vpc_prod_private_subnet_id_c = data.terraform_remote_state.vpc.outputs.vpc_production__private_subnet_id_c

  vpc_prod_private_subnets_id = [
    local.vpc_prod_private_subnet_id_a,
    local.vpc_prod_private_subnet_id_b,
    local.vpc_prod_private_subnet_id_c,
  ]

  vpc_prod_public_subnet_id_a = data.terraform_remote_state.vpc.outputs.vpc_production__public_subnet_id_a
  vpc_prod_public_subnet_id_b = data.terraform_remote_state.vpc.outputs.vpc_production__public_subnet_id_b
  vpc_prod_public_subnet_id_c = data.terraform_remote_state.vpc.outputs.vpc_production__public_subnet_id_a

  vpc_prod_public_subnets_id = [
    local.vpc_prod_public_subnet_id_a,
    local.vpc_prod_public_subnet_id_b,
    local.vpc_prod_public_subnet_id_c,
  ]

  env_production_lower = "production"
  project_analysis     = "analysis"

  spot_default_factor            = 0.8
  spot_on_demand_price_c5_xlarge = 0.192
  spot_bid_price_c5_xlarge = format("%.2f",
    tonumber(tostring(local.spot_on_demand_price_c5_xlarge)) * tonumber(tostring(local.spot_default_factor)),
  )
}


