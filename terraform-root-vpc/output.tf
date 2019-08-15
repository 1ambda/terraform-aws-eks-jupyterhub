output "vpc_production__vpc_id" {
  value = module.vpc_analysis_production.vpc_id
}

output "vpc_production__cidr" {
  value = module.vpc_analysis_production.vpc_cidr_block
}


output "vpc_production__public_subnet_cidr_a" {
  value = module.vpc_analysis_production.public_subnets_cidr_blocks[0]
}

output "vpc_production__public_subnet_cidr_b" {
  value = module.vpc_analysis_production.public_subnets_cidr_blocks[1]
}

output "vpc_production__public_subnet_cidr_c" {
  value = module.vpc_analysis_production.public_subnets_cidr_blocks[2]
}

output "vpc_production__public_subnet_id_a" {
  value = module.vpc_analysis_production.public_subnets[0]
}

output "vpc_production__public_subnet_id_b" {
  value = module.vpc_analysis_production.public_subnets[1]
}

output "vpc_production__public_subnet_id_c" {
  value = module.vpc_analysis_production.public_subnets[2]
}


output "vpc_production__private_subnet_cidr_a" {
  value = module.vpc_analysis_production.private_subnets_cidr_blocks[0]
}

output "vpc_production__private_subnet_cidr_b" {
  value = module.vpc_analysis_production.private_subnets_cidr_blocks[1]
}

output "vpc_production__private_subnet_cidr_c" {
  value = module.vpc_analysis_production.private_subnets_cidr_blocks[2]
}

output "vpc_production__private_subnet_id_a" {
  value = module.vpc_analysis_production.private_subnets[0]
}

output "vpc_production__private_subnet_id_b" {
  value = module.vpc_analysis_production.private_subnets[1]
}

output "vpc_production__private_subnet_id_c" {
  value = module.vpc_analysis_production.private_subnets[2]
}

