module "iam_common" {
  source = "./module-iam_COMMON"

  environment      = local.env_common_lower
}
