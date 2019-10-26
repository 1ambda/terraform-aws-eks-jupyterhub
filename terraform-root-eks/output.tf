//output "efs_jupyter_shared__dns" {
//  value = module.efs_production.efs_dns_jupyter_shared
//}
//
//output "efs_jupyter_shared__sg_id" {
//  value = module.efs_production.sg_id_efs_jupyter_shared
//}
//
output "eks_analysis_production__sg_id_cluster" {
  value = module.eks_extra_production.sg_id_eks_cluster_analysis
}

output "eks_analysis_production__sg_id_worker" {
  value = module.eks_extra_production.sg_id_eks_worker_analysis
}

output "eks_analysis_production__sg_id_public_lb_analysis" {
  value = module.eks_extra_production.sg_id_eks_public_lb_analysis
}

