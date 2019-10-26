# k8s-jupyter-hub

## Preparation 

- [x] `k8s.efs-volume.yaml` 파일 내의 `{EFS-ID}` 값을 수정 ([AWS EFS Console](https://ap-northeast-2.console.aws.amazon.com/efs/home?region=ap-northeast-2#/filesystems))

```bash
# Jupyter Hub 를 위한 EBS, EFS k8s 리소스를 생성 
./jupyter.helm-prepare.sh
```

## Installation

`jupyter.helm-config.yaml` 파일 내의 다음 값들을 수정

- [ ] `secretToken`
- [x] `service.beta.kubernetes.io/aws-load-balancer-extra-security-groups (eks-public-lb-production Group ID)`

```bash
# jupyterhub helm chart 설치
./jupyter.helm-install.sh

# jupyter hub pod 들이 생성되고 있는지 확인 
kubectl get pods -n jupyter-production -w

# 로드밸런서 DNS 확인
kubectl --namespace=jupyter-production get svc proxy-public

NAME           TYPE           CLUSTER-IP     EXTERNAL-IP                                                                    PORT(S)                      AGE
proxy-public   LoadBalancer   172.20.50.70   XXX-YYYY.ap-northeast-2.elb.amazonaws.com   80:30906/TCP,443:32326/TCP   33m
```

만들어진 Jupyter [Load Balancer DNS](https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=ap-northeast-2#LoadBalancers:tag:kubernetes.io/cluster/analysis-production=owned;sort=loadBalancerName) 를 브라우저에서 방문합니다.

초기 사용자 / 패스워드는 `1ambda / mypassword` 입니다. 변경을 원하면 [jupyter.helm-config.yaml](https://github.com/1ambda/terraform-aws-eks-jupyterhub/blob/master/k8s-jupyter-hub/jupyter.helm-config.yaml#L41-L50) 파일 내의 `auth` 수정 한 후 `jupyter.helm-update.sh` 를 실행합니다.

## Update 

jupyter hub helm chart 를 업데이트 하려면 아래의 커맨드를 실행합니다. 

```bash
./jupyter.helm-update.sh
```

## Setup Github OAuth

- [x] [Github Secret for OAuth Authentication](https://github.com/settings/apps) 생성 
- [x] [Github Secret for Jupyterhub Authentication](https://zero-to-jupyterhub.readthedocs.io/en/latest/authentication.html) 설정 참고 
- [x] `jupyter.helm-config.yaml` 파일 내의 `auth.type` and `auth.github` 값 수정 

```bash
./jupyter.helm-update.sh
```
