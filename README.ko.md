# terraform-eks-jupyterhub

[English Version Docs](./README.md)

<br/>

30 분 안에 [Jupyter Hub](https://jupyter.org/hub) 를 [AWS EKS](https://aws.amazon.com/ko/eks/) 위에서 [Terraform](https://www.terraform.io) 을 이용해 띄워봅니다.

## Requirements 

SSH Key `aws_infra_root_key` 를 패스워드 없이 만들고 AWS 에 등록합니다. 
- [Github Guide](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [SSH Key Import in AWS Console](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#how-to-generate-your-own-key-and-import-it-to-aws)

```bash
# AWS 커맨드 라인 툴 설치 
pip install --upgrade awscli

# AWS 크레덴셜 설정
aws configure

# SSH 키 페어 생성하기 - 패스워드 입력하지 않고 (엔터) 
mkdir ~/.ssh || true 
cd ~/.ssh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

Enter a file in which to save the key (/Users/you/.ssh/id_rsa): aws_infra_root_key

# SSH Public Key AWS 로 가져오기 
aws ec2 import-key-pair --key-name "aws_infra_root_key" --public-key-material file://~/.ssh/aws_infra_root_key.pub
```


필요한 CLI 도구들을 설치합니다. 

```bash
# OSX 명령어 
brew install aws-iam-authenticator
brew install terraform
```

- [x] [terraform 0.12+](https://learn.hashicorp.com/terraform/getting-started/install.html) 설치
- [x] [aws-iam-authenticator](https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/install-aws-iam-authenticator.html) 설치

Terraform 프로젝트에 필요한 AWS 리소스를 준비합니다.

- [x] S3 버켓을 다음의 이름으로 생성 `terraform-infra-{SOMETHING}` 
- [x] DynamoDB 테이블을 다음의 이름으로 생성 `terraform-lock-resource`, `terraform-lock-iam`
    * primary key 이름은 다음처럼 지정 `LockID` (**String**)
- [X] Terraform 에서 사용할 S3 백엔드 bucket 의 이름을 다음처럼 변경 `terraform-infra-{SOMETHING}`
    * `terraform.tf` 및 `data.tf` 파일 들 내에서

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

- [x] [k8s-system-helm](./k8s-system-helm/README.ko.md)
- [x] [k8s-system-reloader](./k8s-system-reloader/README.ko.md)
- [x] [k8s-system-dashboard](./k8s-system-dashboard/README.ko.md)
- [ ] [k8s-system-elasticstack](./k8s-system-elasticstack/README.ko.md)
- [ ] [k8s-system-prometheus](./k8s-system-prometheus/README.ko.md)
- [ ] [k8s-system-autoscaler](./k8s-system-autoscaler/README.ko.md)
- [x] [k8s-jupyter-hub](./k8s-jupyter-hub/README.ko.md)
- [x] [k8s-jupyter-nbviewer](./k8s-jupyter-nbviewer/README.ko.md)

## References 

- [terraform-aws-modules/terraform-aws-eks](https://github.com/terraform-aws-modules/terraform-aws-eks) 
- [Deploying Kubernetes Dashboard on AWS EKS](https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/dashboard-tutorial.html)

