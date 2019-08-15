terraform {
  required_version = ">= 0.12.6"

  backend "s3" {
    bucket         = "terraform-infra-poc"
    key            = "terraform-root-iam/tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock-iam"
  }
}

