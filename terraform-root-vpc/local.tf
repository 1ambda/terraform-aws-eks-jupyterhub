locals {
  vpc_prod_prefix          = "vpc"
  vpc_prod_cidr            = "10.0.0.0/16" // use smaller cidr for actual production usage considering vpc peeering:)
  vpc_prod_private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", ]
  vpc_prod_public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24", ]

  env_production_lower = "production"

  eks_cluster_name_analysis_production = "analysis-production"
}