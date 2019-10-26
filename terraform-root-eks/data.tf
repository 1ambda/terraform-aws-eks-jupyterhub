data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket         = "terraform-infra-poc"
    key            = "terraform-root-vpc/tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-resource-lock"
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"

  config = {
    bucket         = "terraform-infra-poc"
    key            = "terraform-root-iam/tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-resource-lock"
  }
}
