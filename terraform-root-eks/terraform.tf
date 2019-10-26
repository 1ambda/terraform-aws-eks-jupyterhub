terraform {
  required_version = ">= 0.12.6"

  backend "s3" {
    bucket         = "terraform-infra-poc"
    key            = "terraform-root-eks/tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-resource-lock"
  }
}

