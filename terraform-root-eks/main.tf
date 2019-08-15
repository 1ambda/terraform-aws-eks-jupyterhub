module "efs_production" {
  source = "./module-efs_PROD"

  environment = local.env_production_lower

  vpc_id               = local.vpc_prod_id
  subnet_id_private_2a = local.vpc_prod_private_subnet_id_a
  subnet_id_private_2b = local.vpc_prod_private_subnet_id_b
  subnet_id_private_2c = local.vpc_prod_private_subnet_id_c
  availability_zones   = var.availability_zones
}

module "eks_extra_production" {
  source = "./module-eks-extra_PROD"

  environment      = local.env_production_lower
  project_analysis = local.project_analysis

  sg_id_efs_jupyter_shared = module.efs_production.sg_id_efs_jupyter_shared

  vpc_id = local.vpc_prod_id
}

module "eks_cluster_analysis_production" {
  # - https://github.com/terraform-aws-modules/terraform-aws-eks/blob/ba3377360e13e4773b27b1c5ec3dfd99b8ef949d/variables.tf
  source = "./component-eks"

  # https://docs.aws.amazon.com/eks/latest/userguide/platform-versions.html
  cluster_name    = "${local.project_analysis}-${local.env_production_lower}"
  cluster_version = "1.13"

  subnets = local.vpc_prod_private_subnets_id

  vpc_id = local.vpc_prod_id

  cluster_create_security_group = false
  worker_create_security_group  = false
  cluster_security_group_id     = module.eks_extra_production.sg_id_eks_cluster_analysis
  worker_security_group_id      = module.eks_extra_production.sg_id_eks_worker_analysis

  # https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]

  # https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  manage_cluster_iam_resources = false
  manage_worker_iam_resources  = false
  cluster_iam_role_name        = local.iam_role_name_eks_cluster

  worker_groups = [
    {
      name          = "eks-${local.project_analysis}-ig-01-${local.env_production_lower}"
      instance_type = "t3.medium"

      root_volume_size = "100"
      root_volume_type = "gp2"

      iam_instance_profile_name = local.iam_role_name_eks_worker
      key_name                  = local.key_pair_name

      subnets = [
        local.vpc_prod_private_subnet_id_a,
        // single AZ
      ]

      autoscaling_enabled  = true
      asg_max_size         = 1
      asg_desired_capacity = 1
      suspended_processes = [
        "AZRebalance",
      ]

      kubelet_extra_args = "--node-labels=kubernetes.io/lifecycle=normal,eks-node-group=jupyter-system"
      # additional_userdata = "echo test"

      tags = [
        {
          key                 = "Name"
          value               = "eks-worker-${local.project_analysis}-ig-01-${local.env_production_lower}"
          propagate_at_launch = true
        },
        {
          key                 = "Environment"
          value               = local.env_production_lower
          propagate_at_launch = true
        },
        {
          key                 = "Terraform"
          value               = "true"
          propagate_at_launch = true
        },
      ]
    },
    {
      name          = "eks-${local.project_analysis}-ig-02-${local.env_production_lower}"
      instance_type = "c5.2xlarge"
      spot_price    = local.spot_bid_price_c5_xlarge

      root_volume_size = "100"
      root_volume_type = "gp2"

      iam_instance_profile_name = local.iam_role_name_eks_worker
      key_name                  = local.key_pair_name

      subnets = [
        local.vpc_prod_private_subnet_id_a,
        // single AZ
      ]

      asg_max_size         = 1
      asg_desired_capacity = 1
      suspended_processes = [
        "AZRebalance",
      ]

      kubelet_extra_args = "--node-labels=kubernetes.io/lifecycle=spot,eks-node-group=jupyter-compute-cpu"
      # additional_userdata = "echo test"

      tags = [
        {
          key                 = "Name"
          value               = "eks-worker-${local.project_analysis}-ig-02-${local.env_production_lower}"
          propagate_at_launch = true
        },
        {
          key                 = "Environment"
          value               = local.env_production_lower
          propagate_at_launch = true
        },
        {
          key                 = "Terraform"
          value               = "true"
          propagate_at_launch = true
        },
      ]
    },
  ]

  tags = {
    Terraform = "true"

    Environment = local.env_production_lower
  }
}