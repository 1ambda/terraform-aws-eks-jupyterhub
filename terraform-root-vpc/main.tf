module "vpc_analysis_production" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v2.9.0"

  name = "${local.vpc_prod_prefix}-${local.env_production_lower}"
  cidr = local.vpc_prod_cidr

  azs             = var.availability_zones
  private_subnets = local.vpc_prod_private_subnets
  public_subnets  = local.vpc_prod_public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  # https://stackoverflow.com/questions/55510783/cant-access-eks-api-server-endpoint-within-vpc-when-private-access-is-enabled
  enable_dns_hostnames = true
  enable_dns_support   = true

  # https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name_analysis_production}" = "shared"
    "kubernetes.io/role/elb"                                              = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name_analysis_production}" = "shared"
    "kubernetes.io/role/internal-elb"                                     = "1"
  }

  tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name_analysis_production}" = "shared"

    Terraform = "true"

    Environment = local.env_production_lower
  }
}