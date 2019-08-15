# terraform-eks-jupyterhub

[한국어 버전 설명서](./README.ko.md)

Running [Jupyter Hub](https://jupyter.org/hub) on [AWS EKS](https://aws.amazon.com/ko/eks/) using [Terraform](https://www.terraform.io) in 30 minutes

## Requirements 

Generate your ssh key named `aws_infra_root_key` without password and import it into AWS 
- [Github Guide](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [SSH Key Import in AWS Console](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#how-to-generate-your-own-key-and-import-it-to-aws)

```
# Install AWS CLI
pip install --upgrade awscli

# configure AWS credential
aws configure

# Generate SSH Key
mkdir ~/.ssh || true 
cd ~/.ssh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
Enter a file in which to save the key (/Users/you/.ssh/id_rsa): aws_infra_root_key

# Import SSH Public Key into AWS
aws ec2 import-key-pair --key-name "aws_infra_root_key" --public-key-material file://~/.ssh/aws_infra_root_key.pub
```

Install required CLI tools.

```bash
# OSX commands
brew install aws-iam-authenticator
brew install terraform
```

- [x] Install [terraform 0.12+](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [x] Install [aws-iam-authenticator](https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/install-aws-iam-authenticator.html)

Then prepare AWS resources to apply terraform projects.

- [x] Create S3 bucket named `terraform-infra-{SOMETHING}` 
- [x] Create DynamoDB table named `terraform-lock-resource` and `terraform-lock-iam`
    * with primary key `LockID` (**String**)
- [X] Modify terraform backend S3 bucket name to `terraform-infra-{SOMETHING}`
    * in `terraform.tf` and `data.tf`

## Project Structure

```
├── k8s-jupyter-nbviewer     # Kubernetes Manifest for NbViewer 
├── k8s-jupyter-hub          # Kubernetes Manifest for Jupyter Hub

├── k8s-system-autoscaler    # Kubernetes Manifest for Cluster Autoscaler 
├── k8s-system-dashboard     # Kubernetes Manifest for Kuberntes Dashboard 
├── k8s-system-elasticstack  # Kubernetes Manifest for ELK Stack 
├── k8s-system-helm          # Kubernetes Manifest for Helm 
├── k8s-system-prometheus    # Kubernetes Manifest for Prometheus 
├── k8s-system-reloader      # Kubernetes Manifest for Reloader 

├── terraform-root-vpc       # Terraform Project for VPC (Network)
├── terraform-root-iam       # Terraform Project for IAM (Role, Permissions)
├── terraform-root-bastion   # Terraform Project for Bastion (EC2)
└── terraform-root-eks       # Terraform Project for EKS (Kubernetes)
```

## Terraforming AWS Infrastructure  

### terraform-root-vpc

```bash
$ teraform init
$ teraform plan

$ terraform apply
```

### terraform-root-iam

```bash
$ teraform init
$ teraform plan

$ terraform apply
```

### terraform-root-bastion

```bash
$ teraform init
$ teraform plan

$ terraform apply
```

### terraform-root-eks

```bash
$ teraform init
$ teraform plan

$ terraform apply

$ aws eks update-kubeconfig --name analysis-production

$ kubectl get nodes

NAME                                                STATUS    ROLES     AGE       VERSION
ip-10-XXX-XXX.XXX.ap-northeast-2.compute.internal   Ready     <none>    2m15s     v1.13.7-eks-c57ff8
ip-10-YYY-YYY-YYY.ap-northeast-2.compute.internal   Ready     <none>    2m15s     v1.13.7-eks-c57ff8
```

## Setup Kubernetes Applications

- [x] [k8s-system-helm](./k8s-system-helm)
- [x] [k8s-system-reloader](./k8s-system-reloader)
- [x] [k8s-system-dashboard](./k8s-system-dashboard)
- [ ] [k8s-system-elasticstack](./k8s-system-elasticstack)
- [ ] [k8s-system-prometheus](./k8s-system-prometheus)
- [ ] [k8s-system-autoscaler](./k8s-system-autoscaler)
- [x] [k8s-jupyter-hub](./k8s-jupyter-hub)
- [x] [k8s-jupyter-nbviewer](./k8s-jupyter-nbviewer)

## References 

- [terraform-aws-modules/terraform-aws-eks](https://github.com/terraform-aws-modules/terraform-aws-eks) 
- [Deploying Kubernetes Dashboard on AWS EKS](https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/dashboard-tutorial.html)

